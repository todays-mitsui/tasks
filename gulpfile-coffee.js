var cache    = require('gulp-cached'); 　// タスク高速化のためにキャッシュ使用

var plumber  = require('gulp-plumber');　// エラー処理用
var notify   = require('gulp-notify'); 　// エラー時の通知用

var coffee   = require('gulp-coffee')  　// CoffeeScriptコンパイル


module.exports = function(gulp) {

  // gulpを実行したカレントディレクトリ
  var cwd   = process.env.INIT_CWD;

  // CoffeeScriptコンパイル対象ファイル
  // /coffee/ディレクトリの中の*.coffeeファイルをコンパイル
  var src   = cwd + '/coffee/*.coffee';

  // CoffeeScriptコンパイル後の保存先ディレクトリ
  // コンパイルされたJSは名前そのままで/js/ディレクトリに入る
  var destd = cwd + '/js/';

  gulp.task('coffee-compile', function() {
    return gulp.src(src)
      .pipe(plumber({
        errorHandler: notify.onError('<%= error.message %>')
      }))
      .pipe(cache('coffee'))
      .pipe(coffee())
      .pipe(gulp.dest(destd));
  });

  // /coffee/ディレクトリ内のファイルの変更を監視してCoffeeScriptコンパイルを都度実行
  gulp.task('coffee', ['coffee-compile'], function() {
    gulp.watch(src, ['coffee-compile']);
  });

}
