mountFolder = ( connect, dir ) ->
    return connect.static(require('path').resolve(dir))

module.exports = (grunt) ->
    grunt.initConfig
        package:
            inPath      : 'dev/grpx.js'
            outputPath  : 'build/grpx.min.js'
            siteLibPath : '../site/javascripts/grpx.min.js'
            name        : 'GRPX lib (https://github.com/tomsoir/grpx)'
            company     : 'Correct Price (http://correctprice.ru/)'
            version     : '0.1.1'
            date        : '<%= grunt.template.today("yyyy-mm-dd") %>'
            page        : 'http://tomsoir.github.io/grpx'
            wiki        : 'https://github.com/tomsoir/grpx/wiki'
        uglify: 
            options: 
                compress: 
                    global_defs: 
                        "DEBUG": false
                    dead_code: true
                wrap: false
                banner: '
/*\n
    <%= package.name %>\n
    <%= package.company %>\n
    version <%= package.version %>\n
    date <%= package.date %>\n*/\n'

            public:
                files:
                    '<%= package.outputPath %>': ['<%= package.inPath %>']

        grunt.loadNpmTasks('grunt-contrib-uglify')

        grunt.registerTask 'build', ['uglify', 'copyToSite']

        #
        # tasks
        #
        grunt.registerTask 'copyToSite', 'Copy build js files to site', ->
            path    = require("path")
            config  = grunt.config.getRaw("package")

            buildPathFile= __dirname+'/'+config.inPath
            sitePathFile = path.join(__dirname, config.siteLibPath)

            exec = require("child_process").exec
            exec 'cp '+buildPathFile+' '+sitePathFile, (e) ->
                grunt.log.error(e) if(e)
            console.log '>', buildPathFile, sitePathFile



