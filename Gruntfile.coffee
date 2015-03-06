mountFolder = ( connect, dir ) ->
    return connect.static(require('path').resolve(dir))

module.exports = (grunt) ->
    grunt.initConfig
        package:
            inPath      : 'dev/grpx.js'
            outputPath  : 'build/grpx.min.js'

            name        : 'GRPX lib (https://github.com/tomsoir/grpx)'
            company     : 'Correct Price (http://correctprice.ru/)'
            version     : '0.1.1'
            date        : '<%= grunt.template.today("yyyy-mm-dd") %>'
            page        : 'http://tomsoir.github.io/grpx'
            wiki        : 'https://github.com/tomsoir/grpx/wiki'

            copyFile1   : ['dev/grpx.js',       '../project/dev/grpx.js']
            copyFile2   : ['dev/grpx.coffee',   '../project/dev/grpx.coffee']
            copyFile3   : ['build/grpx.min.js', '../project/build/grpx.min.js']

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
    date <%= package.date %>\n
    page <%= package.page %>\n
    wiki <%= package.wiki %>\n*/\n'

            public:
                files:
                    '<%= package.outputPath %>': ['<%= package.inPath %>']

        grunt.loadNpmTasks('grunt-contrib-uglify')

        grunt.registerTask('build', ['uglify', 'copyToProject'])

        grunt.registerTask 'copyToProject', 'Copy build js files to site', ->
            config = grunt.config.getRaw("package")
            copyFile(config.copyFile1) 
            copyFile(config.copyFile2) 
            copyFile(config.copyFile3) 

        copyFile = (copyFile) ->
            path = require("path")
            exec = require("child_process").exec
            copyFromFile = path.join(__dirname+'/'+copyFile[0])
            copyIntoFile = path.join(__dirname+'/'+copyFile[1])
            exec 'cp '+copyFromFile+' '+copyIntoFile, (e) -> grunt.log.error(e) if(e)

