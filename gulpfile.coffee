gulp        = require 'gulp'
sass        = require 'gulp-ruby-sass'
plumber     = require 'gulp-plumber'
csscomb     = require 'gulp-csscomb'
pleeease    = require 'gulp-pleeease'

gulp.task 'sass', ->
  gulp.src 'sass/*.sass'
    .pipe plumber()
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
    .pipe gulp.dest '/css/'

