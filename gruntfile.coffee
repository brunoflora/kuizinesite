module.exports = (grunt) ->
    grunt.initConfig
        # Junta os includes nas páginas e cria os arquivos na pasta preview
        htmlbuild:
            all:
                src: 'theme/template/*.html'
                dest: 'theme/'
                options:
                    beautify: true
                    sections:
                        header: 'theme/includes/header.html'
                        menu: 'theme/includes/menu.html'
                        featured: 'theme/includes/featured.html'
                        social: 'theme/includes/social.html'
                        news: 'theme/includes/news.html'
                        category: 'theme/includes/category.html'
                        jornal: 'theme/includes/jornal.html'
                        photos: 'theme/includes/photos.html'
                        videos: 'theme/includes/videos.html'
                        publications: 'theme/includes/publications.html'
                        footer: 'theme/includes/footer.html'

        # Move as dependências do Front-end para pasta do projeto
        concat:
            jquery:
                files:
                    'theme/js/vendor/jquery.js' : 'bower_components/jquery/dist/jquery.js'
            materialize:
                files:
                    'theme/css/vendor/materialize.css' : 'bower_components/materialize/dist/css/materialize.css'
                    'theme/js/vendor/materialize.js' : 'bower_components/materialize/dist/js/materialize.js'
            fontawesome:
                files:
                    'theme/css/vendor/font-awesome.css' : 'bower_components/font-awesome/css/font-awesome.css'

        # Move arquivos complementares das dependências
        copy:
            materialize:
                cwd: 'bower_components/materialize/dist/font'
                src: '**'
                dest: 'theme/font/'
                expand: true
            fontawesome:
                cwd: 'bower_components/font-awesome/fonts'
                src: '**'
                dest: 'theme/font/font-awesome'
                expand: true

        # Troca localização da pasta de fontes do font-awesome
        'regex-replace':
            fontawesome:
                src: 'theme/css/vendor/font-awesome.css'
                actions: [
                    search: '/fonts'
                    replace: '/font/font-awesome'
                    flags: 'g'
                ]
            subfolder:
                src: 'theme/css/vendor/*'
                actions: [
                    search: "/font/"
                    replace: "/../font/"
                    flags: 'g'
                ]

        # Converte arquivos Less pra CSS
        less:
            dev:
                files: 'theme/css/main.css': 'theme/less/main.less'
                options:
                    compress: false
            release:
                files: 'theme/css/main.css': 'theme/less/main.less'
                options:
                    compress: true

        # Monitora alterações nos arquivos e executa tarefas (less e htmlbuild)
        watch:
            styles:
                files: 'theme/less/*.less'
                tasks: 'less:dev'
            includes:
                files: [ 'theme/template/**/*', 'theme/includes/**/*' ]
                tasks: 'htmlbuild:all'

        # Multiple tasks running
        concurrent:
            all:
                tasks: [ 'watch:styles' , 'watch:includes' ]
                options:
                    logConcurrentOutput: true


    grunt.loadNpmTasks 'grunt-contrib-concat'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-less'
    grunt.loadNpmTasks 'grunt-html-build'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-regex-replace'
    grunt.loadNpmTasks 'grunt-concurrent'

    grunt.registerTask 'work', [
        'concurrent:all'
    ]

    grunt.registerTask 'build', [
        'concat'
        'copy'
        'regex-replace'
        'htmlbuild'
        'less'
    ]
