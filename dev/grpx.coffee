((root, factory) ->
    if typeof exports == 'object'
        factory(exports, require('jQuery'))     # CommonJS format
    else if typeof define == 'function' and define.amd
        define(['exports','jQuery'], factory)   # AMD (anonymous module)
    else
        factory(window, $)                      # Export to global
    return
) this, (exports, $) ->


    UTILS = {
        _getImageSrc: (srcImgStr, staticHost)->
            if String(srcImgStr) == 'no'
                return staticHost+'/f/1/global/b/b-calculations/noimg.jpeg'
            else
                return staticHost+'/r/'+srcImgStr+'/1.jpg'

        _formatPriceMatrix: (priceArr, selected_condition) ->
            textsModule = @textsModule

            result = {
                selectedConditionStr    : textsModule[selected_condition]
                selectedCondition       : selected_condition
                groupCondition          : {}
                selectedConditionGroup  : {}
                otherConditionHeads     : []
                otherConditionGroup     : []
            }
            # сначало создаем группы по состояниям
            for price in priceArr
                result.groupCondition[price.cond] = {
                    'way'       : {}
                    'name'      : price.cond
                    'title'     : textsModule[price.cond]
                    'selected'  : if String(selected_condition) is String(price.cond) then true else false
                }
            # добавляем типы цены
            for price in priceArr
                result.groupCondition[price.cond].way[price.way] = price.price
            # добавляем только выбранную группу
            for groupName of result.groupCondition
                group = result.groupCondition[groupName]
                result.selectedConditionGroup = group if group.selected
            # добавляем остальные Не выбранные состояния
            for groupName of result.groupCondition
                group = result.groupCondition[groupName]
                unless group.selected
                    result.otherConditionGroup.push(group) 
                    result.otherConditionHeads.push({
                        name : group.name
                        title: group.title
                    })

            return result

        _monthText: (number) ->
            switch String(number)
                when '1' then text = 'Январь'
                when '2' then text = 'Февраль'
                when '3' then text = 'Март'
                when '4' then text = 'Апрель'
                when '5' then text = 'Май'
                when '6' then text = 'Июнь'
                when '7' then text = 'Июль'
                when '8' then text = 'Август'
                when '9' then text = 'Сентябрь'
                when '10' then text = 'Октябрь'
                when '11' then text = 'Ноябрь'
                when '12' then text = 'Декабрь'
            return text

        _returnParam: (param)->
            return if param then param else undefined

        _getModifyByText: (mod_name) ->
            textsModule =  @textsModule

            # 1) выдаем как массив
            asArray = []
            aChunk = String(mod_name).split('_')
            for chunk in aChunk
                asArray.push if textsModule[String(chunk).toLowerCase()] then textsModule[String(chunk).toLowerCase()] else chunk

            # 2) выдаем как группу
            asGroup = {}
            aChunk = String(mod_name).split('_')
            return {
                'asArray': asArray
                'asGroup':
                    'body':
                        'title' : textsModule[ 'body' ]
                        'value' : textsModule[ String(aChunk[0]).toLowerCase() ]
                    'engine_volume':
                        'title' : textsModule[ 'engine_volume' ]
                        'value' : String(aChunk[1]).replace(/^(.*)\(.*\)$/, '$1') 
                    'power':
                        'title' : textsModule[ 'power' ]
                        'value' : String(aChunk[1]).replace(/^.*\((.*)\)$/, '$1') 
                    'engine_type':
                        'title' : textsModule[ 'engine_type' ]
                        'value' : aChunk[2]
                    'privod':
                        'title' : textsModule[ 'privod' ]
                        'value' : aChunk[3]
                    'transmission':
                        'title' : textsModule[ 'transmission' ]
                        'value' : aChunk[4]
            }

        _getBrandIconByMark: (mark, model, staticHost) ->
            make = String(mark).toLowerCase().trim().replace(/(.+)\s.*/g, '$1')
            for brand in model.brands
                if brand.id is make
                    model = brand 
            if model
                return staticHost+'/r/'+String(model.uuid).trim()+'/icon_'+String(model.file_name).trim()
            else # fix it
                return staticHost+'/r/63806594-6C1E-4C56-BC4B-0E911E967BD4/icon_noimg.jpeg'

        textsModule: 
            'appType':
                    '1' : 'справочник'
                    '2' : 'trade-In'
                    '3' : 'trade-In отправки заявки'
                    '4' : 'разработка внутри компании'

                'reportType':
                    '1' : 'все расчеты и заявки'
                    '2' : 'партнерская статистика'

            'внедорожник 3 door'        : 'Внедорожник 3-х дверный'
            'внедорожник 3 door (new)'  : 'Внедорожник 3-х дверный (обновленный)'
            'внедорожник 5 door'        : 'Внедорожник 5-и дверный'
            'внедорожник 5 door (new)'  : 'Внедорожник 5-и дверный (обновленный)'
            'кабриолет'                 : 'Кабриолет'
            'кабриолет (new)'           : 'Кабриолет (обновленный)'
            'купе'                      : 'Купе'
            'купе (new)'                : 'Купе (обновленный)'
            'минивэн'                   : 'Минивэн'
            'минивэн (new)'             : 'Минивэн (обновленный)'
            'пикап'                     : 'Пикап'
            'пикап (new)'               : 'Пикап (обновленный)'
            'родстер'                   : 'Родстер'
            'родстер (new)'             : 'Родстер (обновленный)'
            'седан'                     : 'Седан'
            'седан (new)'               : 'Седан (обновленный)'
            'универсал'                 : 'Универсал'
            'универсал (new)'           : 'Универсал (обновленный)'
            'хэтчбек 3 door'            : 'Хэтчбек 3-х дверный'
            'хэтчбек 3 door (new)'      : 'Хэтчбек 3-х дверный (обновленный)'
            'хэтчбек 5 door'            : 'Хэтчбек 5-и дверный'
            'хэтчбек 5 door (new)'      : 'Хэтчбек 5-и дверный (обновленный)'

            'userGuidText'              : 'Мы сохраняем 10 последних сделанных вами расчетов.'
            'headerSubText'             : 'Возможности вашего личного кабинета могут быть увеличены.'

            'yes'                       : 'Да'
            'no'                        : 'Нет'

            'normal'                    : 'Нормальное'
            'good'                      : 'Хорошее'
            'excellent'                 : 'Превосходное'
            'owners'                    : 'Владелец'
            'color'                     : 'Цвет кузова'
            'ckeys'                     : 'Количество ключей'
            'condition'                 : 'Состояние автомобиля'
            'genuine_docs'              : 'Наличие документов'
            's_color'                   : 'Цвет салона'
            'sbook'                     : 'Наличие сервисной книжки'
            'aerography'                : 'Аэрография'

            'body'                      : 'Кузов'
            'engine_volume'             : 'Объем двигателя'
            'power'                     : 'Мощность'
            'engine_type'               : 'Тип двигателя'
            'privod'                    : 'Привод'
            'transmission'              : 'Коробка передач'

    }


    class Print
        minimalOptions: ['year','mid','cmid', 'agemonths','grp0','grp1','grp2','grp3','grp4','grp5','grp6','grp7','mileage','version']

        model:
            details : undefined
            price   : undefined
            brands  : undefined

        constructor: (GRPX, options) ->
            @GRPX = GRPX
            @staticHost = GRPX.config.staticHost
            @options = options

        getData: ->
            result = $.Deferred()

            # проверяем есть ли необходимые опции
            if @_checkOptions(result)
                # проверяем загружен ли GRPX lib
                @GRPX._onload arguments, =>
                    # достаем все необходимое
                    @_getRequireData().done =>
                        # возвращаем ответ с отформатированными данными
                        result.resolve @_prepareResultData()
            return result

        _getRequireData: ->
            state = $.Deferred()
            check = => state.resolve() if @model.details and @model.price and @model.brands

            # получаем полные данные о расчете
            unless @model.details
                @_sendRequest('get_full_details').done (data)=> 
                    @model.details = data[0]
                    check()

            # получаем матрицу стоимости
            unless @model.price
                @_sendRequest('get_calculation').done (data)=> 
                    @model.price = data
                    check()

            # получаем матрицу стоимости
            unless @model.brands
                @_sendRequest('get_brands').done (data)=> 
                    @model.brands = data
                    check()
            check()
            return state

        _sendRequest: (name)->
            switch name
                when 'get_full_details'
                    params = [
                        'year='+@options.year
                        'mid='+@options.mid
                        'cmid='+@options.cmid
                        'version='+@options.version
                    ]
                    return @GRPX.createRequest('get_full_details', params.join('&')+'&')

                when 'get_calculation'
                    params = [
                        'year='+@options.year
                        'mid='+@options.mid
                        'cmid='+@options.cmid
                        'version='+@options.version
                        'agemonths='+@options.agemonths
                        'mileage='+@options.mileage
                        'grp0='+@options.grp0
                        'grp1='+@options.grp1
                        'grp2='+@options.grp2
                        'grp3='+@options.grp3
                        'grp4='+@options.grp4
                        'grp5='+@options.grp5
                        'grp6='+@options.grp6
                        'grp7='+@options.grp7
                        'country=' + if @options.country then @options.country  else 'RU'
                        'province='+ if @options.province then @options.province else '47'
                    ]
                    return @GRPX.createRequest('get_calculation', params.join('&')+'&')

                when 'get_brands'
                    return @GRPX.createRequest('get_brands')

        _checkOptions: (result)->
            state = false
            if @options
                for param in @minimalOptions 
                    if typeof @options[param] is 'undefined'
                        state = false
                state = true
            unless state
                console.error 'minimal options missing: '+@minimalOptions.join(', ')
                result.reject()
            return state

        _prepareResultData: ->
            return {
                'image': UTILS._getImageSrc('no', @staticHost)
                'price': UTILS._formatPriceMatrix(@model.price.price, @model.price.selected_condition)

                'date':
                    'yearProduction'        : @options.year
                    'yearRegistration'      : @options.year #???
                    'monthRegistration'     : 1 #???
                    'monthRegistrationStr'  : UTILS._monthText(1) #???

                'make'                  : @model.details.make
                'makeIcon'              : UTILS._getBrandIconByMark( @model.details.make, @model, @staticHost )
                'model'                 : @model.details.model
                'modify'                : UTILS._getModifyByText( @model.details.mod_name )
                'compllectation' :
                    'base'  : UTILS._returnParam(@model.details.compl_base_name)
                    'name'  : UTILS._returnParam(@model.details.compl_name)
                    'full'  : if @model.details.compl_base_name then @model.details.compl_name+' ('+@model.details.compl_base_name+')' else @model.details.compl_name

                'mileage'   : @options.mileage
                'version'   : @options.version
                'agemonths' : @options.agemonths
            }


    class $GRPX
        ready: false

        desc: undefined
        sect: undefined

        config:
            staticHost: 'http://correctprice.ru'
            masterApi : 'http://api.correctprice.ru'
            backupApi : 'http://api2.correctprice.ru'

        constructor: (options) ->
            if @_jqueryReady()
                @requiresReady()

        _jqueryReady: ->
            return true  if $.isReady 
            console.error 'jQuery not ready. Placed this call into $(function{ ... })' 
            return false

        createRequest: (service, params) ->
            state = $.Deferred()
            params= if params then params else ''
            $.ajax
                url: @config.masterApi+'/'+service+'?'+params+'jsoncallback=?'
                timeout: 3000
                dataType: "json", 
                success: (data) =>  
                    if data?
                        state.resolve(data)
                error: =>
                    unless @config.masterApi is @config.backupApi
                        @config.masterApi = @config.backupApi
                        @createRequest(service, params)
                    else
                        console.error 'Error plugin Correct Price api service'
            return state

        requiresReady: ->
            @_readyState = $.Deferred()
            unless @desc or @sect
                check = => 
                    if @desc and @sect
                        @ready = true
                        @_readyState.resolve()
                @createRequest('get_opt_desc').done (data)=> @desc = data; check()
                @createRequest('get_opt_sect').done (data)=> @sect = data; check()
            else
                @_readyState.resolve()
            return @_readyState

        _onload: (args, fn) ->
            if @_jqueryReady()
                self = @
                state= $.Deferred()
                @_readyState.done -> 
                    result = fn.apply(self, args)
                    state.resolve(result)
                return state
            else
                return { done: -> return false }





        pack: (oParams)->
            return @_onload arguments, @_pack
        _pack: (oParams)->
            opt_desc = @desc
            opt_sect = @sect
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

        unpack: (oGRP)->
            return @_onload arguments, @_unpack
        _unpack: (oGRP)->
            opt_desc = @desc
            opt_sect = @sect
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

        unpackToDefault: (oGRP)->
            return @_onload arguments, @_unpackToDefault
        _unpackToDefault: (oGRP) ->
            resultOpt = {}
            defaultOpt= @_unpack(oGRP)
            for groupName of defaultOpt
                for optName of defaultOpt[groupName]
                    resultOpt[optName] = defaultOpt[groupName][optName][0]
            return resultOpt

        _extendIncomingToDefault: (defaultUnpackOpts, incomingUnpackOpts) ->
            for optName of incomingUnpackOpts
                if defaultUnpackOpts[optName]
                    defaultUnpackOpts[optName] = incomingUnpackOpts[optName]
                else
                    console.error "Can't find param with name: "+optName
            return defaultUnpackOpts

        packWithDefault: (oIncomingOpt, oGRP)->
            return @_onload arguments, @_packWithDefault
        _packWithDefault: (oIncomingOpt, oGRP)->
            defaultOpts= @_unpackToDefault(oGRP)
            resultOpts = @_extendIncomingToDefault(defaultOpts, oIncomingOpt)
            grpx = @_pack(resultOpts)
            return grpx


        getFullDetales: (options)->
            @_printClass = new Print(@, options) unless @_printClass?
            return @_printClass.getData()

    exports.$GRPX = $GRPX unless exports.$GRPX

    return $GRPX
