((root, factory) ->
    if typeof exports == 'object'
        factory(exports, require('jQuery'))     # CommonJS format
    else if typeof define == 'function' and define.amd
        define(['exports','jQuery'], factory)   # AMD (anonymous module)
    else
        factory(window, $)                      # Export to global
    return
) this, (exports, $) ->

    return exports.GRPX =  class GRPX
        config:
            desc: undefined
            sect: undefined
            masterApi : 'api.correctprice.ru'
            backupApi : 'api2.correctprice.ru'
            developApi: 'api-dev.correctprice.ru'

        # options:
        # {dev: true}
        constructor: (options) ->
            @_applyOptions(options)
            @_requiresReady()

        _getProtocol: ->
            return if (window.location.protocol != "https:") then 'http://' else 'https://'

        _applyOptions: (options) ->
            @config.masterApi = @config.developApi if options?.dev 

        _sendRequest: (service, oParams) ->
            state = $.Deferred()
            param = unless oParams then '' else '1';
            $.ajax({
                url: @_getProtocol()+@config.masterApi+'/'+service+'?'+param+'jsoncallback=?', dataType: "json", 
                timeout: 3000
                success: (data) => 
                    state.resolve(data)
                error: =>
                    @config.masterApi = @config.backupApi
                    @_requiresReady()
            })
            return state

        _requiresReady: ->
            $ =>
                state = $.Deferred()
                unless @config.desc or @config.sect
                    check = => state.resolve() if @config.desc and @config.sect
                    @_sendRequest('get_opt_desc').done (data)=> @config.desc = data; check()
                    @_sendRequest('get_opt_sect').done (data)=> @config.sect = data; check()
                else
                    state.resolve()
                return state

        unpack: (oGRP)->
            opt_desc = @config.desc
            opt_sect = @config.sect
            compls = oGRP

            opt_sect_rev = {}
            allGroupsTitle = []
            currentGroupName = ''
            $(opt_sect).each (ind, el) ->
                opt_sect_rev[el.catg]= el.sect
                if currentGroupName != el.sect
                    currentGroupName = el.sect
                    flagExist = false
                    for item in allGroupsTitle
                        flagExist = true if item == currentGroupName
                    unless flagExist
                        allGroupsTitle.push(currentGroupName)

            # фильтруем данные
            $(compls).each (ind2, el2) ->
                el2.options = {}
                $(opt_desc).each (ind3, el3) ->
                    s = el2["grp" + el3.grp]
                    ofs = Math.ceil(s.length - el3.pos / 4 - 1)
                    if parseInt("0x" + s.substring(ofs, ofs + 1)) & Math.pow(2, el3.pos % 4)
                        sect = opt_sect_rev[el3.catg]
                        if el2.options[sect] is `undefined`
                            el2.options[sect] = {}
                        if el2.options[sect][el3.catg] is `undefined`
                            el2.options[sect][el3.catg] = el3.name
                        else if el2.options[sect][el3.catg] instanceof Array
                            el2.options[sect][el3.catg].push el3.name
                        else
                            el2.options[sect][el3.catg] = [el2.options[sect][el3.catg], el3.name]
            return compls.options

        pack: (oParams)->
            opt_desc = @config.desc
            opt_sect = @config.sect
            oFinalPackData = {}

            grps = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]]
            $(opt_desc).each (ind, el) ->
                if typeof (oParams[el.catg]) isnt "undefined" and oParams[el.catg] is el.name
                    grps[el.grp][(if el.pos > 31 then 1 else 0)] += Math.pow(2, (if el.pos > 31 then el.pos - 32 else el.pos))
            simplify = (str) ->
                str = str.substr(1)  while str.length > 1 and str.substr(0, 1) is "0"
                return str
            $(grps).each (ind, el) ->
                el[1] = simplify(el[1].toString(16) + ("00000000" + el[0].toString(16)).substr(-8))
                el[0] = "grp" + ind

            returnStr = 'grp0=' + grps[0][1] + '&grp1=' + grps[1][1] + '&grp2=' + grps[2][1] + '&grp3=' + grps[3][1] + '&grp4=' + grps[4][1] + '&grp5=' + grps[5][1] + '&grp6=' + grps[6][1] + '&grp7=' + grps[7][1]
            oFinalPackData['url'] = returnStr
            oFinalPackData['obj'] = {
                'grp0': grps[0][1]
                'grp1': grps[1][1]
                'grp2': grps[2][1]
                'grp3': grps[3][1]
                'grp4': grps[4][1]
                'grp5': grps[5][1]
                'grp6': grps[6][1]
                'grp7': grps[7][1]
            }
            return oFinalPackData

        unpackToDefault: (oGRP) ->
            resultOpt = {}
            defaultOpt= @unpack(oGRP)
            for groupName of defaultOpt
                for optName of defaultOpt[groupName]
                    resultOpt[optName] = defaultOpt[groupName][optName][0]
            return resultOpt

        extendIncomingToDefault: (defaultUnpackOpts, incomingUnpackOpts) ->
            for optName of incomingUnpackOpts
                if defaultUnpackOpts[optName]
                    defaultUnpackOpts[optName] = incomingUnpackOpts[optName]
                else
                    console.error "Can't find param with name: "+optName
            return defaultUnpackOpts

        packWithDefault: (oIncomingOpt, oGRP)->
            defaultOpts= @unpackToDefault(oGRP)
            resultOpts = @extendIncomingToDefault(defaultOpts, oIncomingOpt)
            grpx = @pack(resultOpts)
            return grpx

