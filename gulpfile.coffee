gulp     = require 'gulp'
watch    = require 'gulp-watch'
flatten  = require 'gulp-flatten'

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
  console.log process.env.INIT_CWD

### Sass ###

gulp.task 'sass', ->
  gulp.src "#{process.env.INIT_CWD}/{sass,scss}/**/*.{sass,scss}"
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
    .pipe flatten()
    .pipe gulp.dest "#{process.env.INIT_CWD}/css/"
    .pipe browserSync.reload
      stream: true

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
    .pipe gulp.dest './'


### Browser Sync ###

gulp.task 'browser-sync', ->
  browserSync
    server:
      baseDir: "#{process.env.INIT_CWD}/"

gulp.task 'browser-sync-reload', ->
  browserSync.reload()

gulp.task 'preview', ['browser-sync'], ->
  gulp.watch "#{process.env.INIT_CWD}/{sass,scss}/**/*.{sass,scss}", ['sass']
  gulp.watch "#{process.env.INIT_CWD}/**/*.{html,php}", ['browser-sync-reload']
