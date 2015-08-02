var cache    = require('gulp-cached');    // タスク高速化のためにキャッシュ使用
var flatten  = require('gulp-flatten');   // ネストしたディレクトリ構造をフラットにする
var filter   = require('gulp-filter');    // 特定の拡張子以外のファイルをフィルターする

var plumber  = require('gulp-plumber');   // エラー処理用
var notify   = require('gulp-notify');    // エラー時の通知用

var sass     = require('gulp-ruby-sass'); // Sassを呼び出す
var csscomb  = require('gulp-csscomb');   // CSSプロパティをルール通りに並び替え
var pleeease = require('gulp-pleeease');  // ベンダープレフィックスの付け外し、remのfallbackなど


module.exports = function(gulp) {

  // gulpを実行したカレントディレクトリ
  var cwd   = process.env.INIT_CWD;

  // Sassコンパイル元のディレクトリ
  // /sass/ディレクトリの中のファイルを対象にコンパイル
  var srcd  = cwd + '/sass/';

  // Sassコンパイル後の保存先ディレクトリ
  // コンパイルされたCSSは名前そのままで/css/ディレクトリに入る
  var destd = cwd + '/css/';

  // 1回だけのSassコンパイルタスク、SCSSファイルもSASSファイルも対応
  // SourceMap無し
  // CSScombを通った後で"--style expanded"っぽくなる
  gulp.task('sass-compile', function() {
    return sass(srcd, {sourcemap: false})
      .on('error', function (err) {
        console.log(err.plugin, err.message);
      })
      .pipe(plumber({
        errorHandler: notify.onError('<%= error.message %>')
      }))
      .pipe(cache('sass'))
      .pipe(filter('**/*.css'))
      .pipe(pleeease({
        fallbacks: {
          autoprefixer: [
            'last 4 versions',
            'last 5 IE versions',
            'last 2 Chrome versions',
            'last 2 Firefox versions',
            'Android >= 4',
            'Android 2.3',
            'iOS >= 6',
          ]},
        minifier: false,
        rem: ['10px']
      }))
      .pipe(csscomb({configPath: './tasks/.csscomb.json'}))
      .pipe(flatten())
      .pipe(gulp.dest(destd));
  });

  // /sass/ディレクトリ内のファイルの変更を監視してSassコンパイルを都度実行
  gulp.task('sass', ['sass-compile'], function() {
    var src = srcd + '*.{sass,scss}';
    gulp.watch(src, ['sass-compile']);
  });

}
