gulp     = require 'gulp'
watch    = require 'gulp-watch'

plumber  = require 'gulp-plumber'
notify   = require 'gulp-notify'

sass     = require 'gulp-ruby-sass'
csscomb  = require 'gulp-csscomb'
pleeease = require 'gulp-pleeease'

coffee   = require 'gulp-coffee'
jshint   = require 'gulp-jshint'

imagemin = require 'gulp-imagemin'
#pngcrush = require 'imagemin-pngcrush'
optipng  = require 'imagemin-optipng'
jpegtran = require 'imagemin-jpegtran'
gifsicle = require 'imagemin-gifsicle'

browserSync = require 'browser-sync'

gulp.task 'test', ->
  console.log __dirname

### Sass ###

gulp.task 'sass', ->
  gulp.src ['./{sass,scss}/**/*.{sass,scss}']
    .pipe plumber
      errorHandler: notify.onError '<%= error.message %>'
    .pipe sass
      style: 'expanded'
    .pipe csscomb()
    .pipe pleeease
      fallbacks:
        autoprefixer: [
          'last 5 IE versions',
          'last 2 Chrome versions',
          'last 2 Firefox versions',
          'Android 2.3',
          'Android >= 4',
          'iOS >= 6'
        ]
      minifier: false
    .pipe gulp.dest './css/'

gulp.task 'sass-watch', ->
  gulp.watch ['sass/**/*.sass', 'sass/**/*.scss', 'scss/**/*.sass', 'scss/**/*.sass'], ['sass']


### Coffee Script ###

gulp.task 'coffee', ->
  gulp.src 'coffee/**/*.coffee'
    .pipe plumber
      errorHandler: notify.onError '<%= error.message %>'
    .pipe coffee()
    .pipe gulp.dest './js/'

gulp.task 'coffee-watch', ->
  gulp.watch 'coffee/**/*.coffee', ['coffee']


### Image Min ###

gulp.task 'imagemin', ->
  gulp.src ['!node_modules/**/*', '**/img/**/*.{png,jpg,jpeg,gif}']
    .pipe imagemin
      progressive: true
      svgoPlugins: [removeViewBox: false]
      use: [optipng(), jpegtran(), gifsicle()]
    .pipe gulp.dest __dirname


### JS Hint ###

gulp.task 'hint', ->
  gulp.src ['**/*.js', '!node_modules/**/*.js']
    .pipe jshint()
    .pipe jshint.reporter 'default'
      use: [pngcrush()]
    .pipe gulp.dest './'


### Browser Sync ###

gulp.task 'browser-sync', ->
  browserSync
    server
      baseDir: './'

gulp.task 'browser-sync-reload', ['sass'], ->
	browserSync.reload()

gulp.task 'preview', ['browser-sync'] ->
  gulp.watch ['./{sass,scss}/**/*.{sass,scss}', './**/*.{html,php}'], ['browser-sync-reload']
