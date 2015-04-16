module.exports = (gulp) ->
  # gulp        = require 'gulp'
  # util        = require 'gulp-util'
  watch       = require 'gulp-watch'

  # concat      = require 'gulp-concat'
  changed     = require 'gulp-changed'
  flatten     = require 'gulp-flatten'
  gulpFilter  = require 'gulp-filter'

  plumber     = require 'gulp-plumber'
  notify      = require 'gulp-notify'

  sass        = require 'gulp-ruby-sass'
  csscomb     = require 'gulp-csscomb'
  pleeease    = require 'gulp-pleeease'

  coffee   = require 'gulp-coffee'

  # spritesmith = require 'gulp.spritesmith'

  # kss         = require 'gulp-kss'

  browserSync = require 'browser-sync'


  ### Compile Sass ###

  gulp.task 'sass', ->
    filter   = gulpFilter ['**/*.css']
    gulp.src "#{process.env.INIT_CWD}/{sass,scss}/*.{sass,scss}"
      .pipe plumber
        errorHandler: notify.onError '<%= error.message %>'
      .pipe sass
        style: 'expanded'
      .pipe filter
      .pipe pleeease
        fallbacks:
          autoprefixer: [
            'last 4 versions',
            'last 5 IE versions',
            'last 2 Chrome versions',
            'last 2 Firefox versions',
            'Android >= 4',
            'Android 2.3',
            'iOS >= 6',
          ]
        minifier: false
        rem: ['10px']
      .pipe csscomb()
      .pipe flatten()
      .pipe gulp.dest "#{process.env.INIT_CWD}/css/"
      .pipe browserSync.reload
        stream: true
    return

  gulp.task 'sass-changed', ->
    filter   = gulpFilter ['**/*.css']
    gulp.src "#{process.env.INIT_CWD}/{sass,scss}/*.{sass,scss}"
      .pipe changed "#{process.env.INIT_CWD}/css/"
      .pipe plumber
        errorHandler: notify.onError '<%= error.message %>'
      .pipe sass
        style: 'expanded'
      .pipe filter
      .pipe pleeease
        fallbacks:
          autoprefixer: [
            'last 4 versions',
            'Android >= 4',
            'Android 2.3',
            'iOS >= 6',
          ]
        minifier: false
        rem: ['10px']
      .pipe csscomb()
      .pipe flatten()
      .pipe gulp.dest "#{process.env.INIT_CWD}/css/"
      .pipe browserSync.reload
        stream: true
    return


  ### Coffee Script ###

  gulp.task 'coffee', ->
    gulp.src "#{process.env.INIT_CWD}/coffee/**/*.coffee"
      .pipe plumber
        errorHandler: notify.onError '<%= error.message %>'
      .pipe coffee()
      .pipe gulp.dest  "#{process.env.INIT_CWD}/js/"
      .pipe browserSync.reload
        stream: true
    return

  gulp.task 'coffee-changed', ->
    gulp.src "#{process.env.INIT_CWD}/coffee/**/*.coffee"
      .pipe changed "#{process.env.INIT_CWD}/js/"
      .pipe plumber
        errorHandler: notify.onError '<%= error.message %>'
      .pipe coffee()
      .pipe gulp.dest  "#{process.env.INIT_CWD}/js/"
      .pipe browserSync.reload
        stream: true
    return

  ### Run WebServer ###

  gulp.task 'browser-sync', ['sass', 'coffee'], ->
    browserSync
      server:
        baseDir: process.env.INIT_CWD

  gulp.task 'browser-sync-reload', ->
    browserSync.reload()

  gulp.task 'sass-watch', ['browser-sync'], ->
    gulp.watch "#{process.env.INIT_CWD}/{sass,scss}/**/*.{sass,scss}", ['sass-changed']

  gulp.task 'preview', ['browser-sync'], ->
    gulp.watch "#{process.env.INIT_CWD}/{sass,scss}/**/*.{sass,scss}", ['sass-changed']
    gulp.watch "#{process.env.INIT_CWD}/coffee/**/*.coffee", ['coffee']
    gulp.watch "#{process.env.INIT_CWD}/css/**/*.css", ['browser-sync-reload']
    gulp.watch "#{process.env.INIT_CWD}/**/*.{html,php}", ['browser-sync-reload']


