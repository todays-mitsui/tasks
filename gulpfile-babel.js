var cache   = require('gulp-cached'); 　// タスク高速化のためにキャッシュ使用

var plumber = require('gulp-plumber');　// エラー処理用
var notify  = require('gulp-notify'); 　// エラー時の通知用

var coffee  = require('gulp-coffee');  　// CoffeeScriptコンパイル

var browserify = require('browserify');
var babelify   = require('babelify');
var source     = require('vinyl-source-stream');

var glob = require('glob');
var path = require('path');

module.exports = function(gulp) {

  // gulpを実行したカレントディレクトリ
  var cwd   = process.env.INIT_CWD;

  // Babel コンパイル対象ファイル
  // /babel/ ディレクトリの中の *.js ファイル, *.es6 ファイル, *.es2015ファイル をコンパイル
  var src   = cwd + '/babel/*.{js,es6,es2015}';

  // Babel コンパイル後の保存先ディレクトリ
  // コンパイルされたJSは名前そのままで/js/ディレクトリに入る
  var destd = cwd + '/js/';


  gulp.task('babel-compile', function() {
    glob(src, function (err, files) {
      if (err) throw err;

      files.forEach(function(filepath) {
        var filename = path.basename(filepath);
        if (filename.match(/^_/)) return;

        browserify(filepath, {debug: false})
          .transform(babelify)
          .bundle()
          .on('error', function (error) {
            console.log("Error : " + error.message);
            plumber({
              errorHandler: notify.onError('<%= error.message %>')
            })
          })
          // .on('error', function (error) {
          //   console.log("Error : " + err.message);
          // })
          .pipe(source(filename+'.js'))
          .pipe(plumber({
            errorHandler: notify.onError('<%= error.message %>')
          }))
          .pipe(gulp.dest(destd));
      });
    });
  });

  // /babel/ ディレクトリ内のファイルの変更を監視して Babel コンパイルを都度実行
  gulp.task('babel', ['babel-compile'], function() {
    gulp.watch(src, ['babel-compile']);
  });

}
