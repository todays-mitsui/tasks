gulp     = require 'gulp'

plumber  = require 'gulp-plumber'
notify   = require 'gulp-notify'

sass     = require 'gulp-ruby-sass'
csscomb  = require 'gulp-csscomb'
pleeease = require 'gulp-pleeease'

coffee   = require 'gulp-coffee'
jshint   = require 'gulp-jshint'

imagemin = require 'gulp-imagemin'
pngcrush = require 'imagemin-pngcrush'


gulp.task 'sass', ->
  gulp.src 'sass/**/*.sass'
    .pipe plumber
      errorHandler: notify.onError '<%= error.message %>'
    .pipe sass
      style: 'expanded'
    .pipe csscomb()
    .pipe pleeease
      fallbacks:
        autoprefixer: [
          'last 4 versions',
          'Android 2.3',
          'Android >= 4',
          'iOS >= 6'
        ]
      minifier: false
    .pipe gulp.dest 'css/'

gulp.task 'sass-watch', ->
  gulp.watch 'sass/**/*.sass', ['sass']


gulp.task 'coffee', ->
  gulp.src 'coffee/**/*.coffee'
    .pipe plumber
      errorHandler: notify.onError '<%= error.message %>'
    .pipe coffee()
    .pipe gulp.dest 'js/'

gulp.task 'coffee-watch', ->
  gulp.watch 'coffee/**/*.coffee', ['coffee']


gulp.task 'imagemin', ->
  gulp.src '**/img/*'
    .pipe imagemin
      progressive: true
      svgoPlugins: [removeViewBox: false]
      use: [pngcrush()]
    .pipe gulp.dest 'img/'

gulp.task 'hint', ->
  gulp.src ['**/*.js', '!node_modules/**/*.js']
    .pipe jshint()
    .pipe jshint.reporter 'default'
