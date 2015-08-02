var config      = require('./config');

var connect     = require('gulp-connect-php');
var browserSync = require('browser-sync');

module.exports = function(gulp) {

  // gulpを実行したカレントディレクトリ
  var cwd = process.env.INIT_CWD;

  // CoffeeScriptコンパイル対象ファイル
  // /coffee/ディレクトリの中の*.coffeeファイルをコンパイル
  var src = cwd + '/**/*.{html,php,css,js}';

  gulp.task('preview-init', function() {
    connect.server({
      port: 8000,
      base: cwd,
      bin:  config.php_bin,
      ini:  config.php_ini,
    }, function() {
      browserSync({
        proxy: 'localhost:8000',
        port: config.port,
      });
    });
  });

  gulp.task('reload', function() {
    browserSync.reload();
  });

  gulp.task('preview', ['preview-init'], function() {
    gulp.watch(src, ['reload']);
  });

}
