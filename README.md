# gulp tasks

gulp.jsのタスクを作り込んでいってます。

## タスク一覧

### Sass

```bash
gulp sass-compile
```

Sassをコンパイルするタスクです。

`./sass/`ディレクトリの中のSASSファイル,SCSSファイルをCSSにコンパイルします。  
出来上がったCSSファイルは`./css/`ディレクトリに保存されます。

Sassコンパイルに続いて以下の処理を実行します。

- [pleeease](http://pleeease.io/)でプロパティをいい感じにする
  - ベンダープレフィックスの最適化
  - メディアクエリをまとめる
  - `rem`のfall back(基準は 1rem=10px で)
- [CSScomb](http://csscomb.com/)でプロパティをいい感じに並べる

最終的に`--style expanded`っぽい形になります。

<br>

```bash
gulp sass
```

上記の`gulp sass-compile`タスクを`./sass/`ディレクトリの中を`watch`しつつ断続的に行います。

<br>

---

### CoffeeScript

```bash
gulp coffee-compile
```

CoffeeScriptをコンパイルするタスクです。

`./coffee/`ディレクトリの中のCOFFEEファイルをJSにコンパイルします。  
出来上がったJSファイルは`./js/`ディレクトリに保存されます。

<br>

```bash
gulp coffee
```

上記の`gulp coffee-compile`タスクを`./coffee/`ディレクトリの中を`watch`しつつ断続的に行います。

<br>

---

### Sass & CoffeeScript

```bash
gulp
```

デフォルトタスク。上記の`gulp sass`と`gulp coffee`を合わせたタスクです。

`./sass/`ディレクトリと`./coffee/`ディレクトリの中を`watch`しつつSassコンパイルとCoffeeScriptコンパイルを断続的に行います。

<br>

---

### Local Server

```bash
gulp preview
```

[PHPのビルトインウェブサーバー](http://php.net/manual/ja/features.commandline.webserver.php)を立ち上げてウェブサイトをローカル環境でプレビューするタスクです。

`gulp preview`を実行すると`./`をDocument Rootとして`localhost:80`にローカルサーバーが立ち上がります。  
ブラウザで`http://localhost/`にアクセスしてください。

Document Root内のHTML, PHP, CSS, JSを`watch`して、変更があった場合には自動的にブラウザをリロードします。

**注意**  
環境に応じてPHPの実行ファイルと`php.ini`の場所を指定する必要があります。  
`tasks/config.js`にオブジェクト形式で絶対パスを記述します。  
Windows用,Mac用それぞれのサンプルとして`config.js.win-sample`と`config.js.mac-sample`を用意しているので適宜 拡張子を変更して使用してください。

Apacheが立ち上がっている訳ではないので、`mod_rewrite`等Apache固有の機能は利用できません。  
また、`.htaccess`でPHPの設定を変更しているものについても反映されません。PHPの設定はphp.iniにあらかじめ記述しておく必要があります。

<br>

---

### Local Server & Sass & CoffeeScript

```bash
gulp develop
```

上記の`gulp preview`と`gulp sass`, `gulp coffee`を合わせたタスクです。

`./sass/`ディレクトリと`./coffee/`ディレクトリの中を`watch`してSassコンパイルとCoffeeScriptコンパイルを断続的に行いつつ、ローカルサーバーでプレビューします。

<br>

## タスク実行までのセットアップ

※*タスクの実行にはRuby, Sass, NodeJSがインストールされている必要があります。  
　セットアップ前にインストールを済ませておいてください。*

このgulpタスクは複数のプロジェクトで共通に使うことを想定しています。

例として、以下のようにプロジェクトA, プロジェクトB, プロジェクトCのファイルを格納したディレクトリがあるとき、
`tasks`ディレクトリはすべてのプロジェクトディレクトリを格納するディレクトリ(下記の例では`projects`ディレクトリ)
の下に配置してください。

```
projects
 ├─ project_A
 │　  ├─ sass
 │　  ├─ css
 │　  └─ index.html
 │
 ├─ project_B
 │　  ├─ sass
 │　  ├─ css
 │　  └─ index.html
 │
 ├─ test
 │　  └─ project_C
 │　　　　  ├─ css
 │　　　　  ├─ sass
 │　　　　  └─ index.html
 │
 └─ tasks  <- cloneしたtasksディレクトリをこの位置に配置
 　　  ├─ .csscomb.json
 　　  ├─ config.js
 　　  ├─ gulpfile-coffee.js
 　　  ├─ gulpfile-default.js
 　　  ├─ gulpfile-develop.js
 　　  ├─ gulpfile-preview.js
 　　  ├─ gulpfile-sass.js
 　　  ├─ gulpfile.js
 　　  └─ package.json
```

<br>

次にtasksディレクトリのうち、`gulpfile.js`と`package,json`を一つ上のディレクトリに移動します。

```
projects
 ├─ project_A
 │　  ├─ sass
 │　  ├─ css
 │　  └─ index.html
 │
 ├─ project_B
 │　  ├─ sass
 │　  ├─ css
 │　  └─ index.html
 │
 ├─ test
 │　  └─ project_C
 │　　　　  ├─ css
 │　　　　  ├─ sass
 │　　　　  └─ index.html
 │
 ├─ tasks
 │　  ├─ .csscomb.json
 │　  ├─ config.js
 │　  ├─ gulpfile-coffee.js
 │　  ├─ gulpfile-default.js
 │　  ├─ gulpfile-develop.js
 │　  ├─ gulpfile-preview.js
 │　  └─ gulpfile-sass.js
 │
 ├─ gulpfile.js   <- この2つのファイルをtasksディレクトリから出して
 └─ package.json  <- この位置に配置する
```

<br>

コマンドプロンプトまたはターミナルを開いて`projects`ディレクトリに移動し、以下のコマンドを実行してセットアップします。

```bash
npm install -g gulp
npm install
```

必要なモジュールのインストールが完了すればセットアップ完了です。

テストとして`project_A`ディレクトリに移動してSassのコンパイルを実行してみます。

```bash
~/projects$ cd project_A
~/projects/project_A$ gulp sass-compile
[12:11:56] Working directory changed to ~/projects
[12:12:11] Using gulpfile ~/projects/gulpfile.js
[12:12:11] Starting 'sass-compile'...
```

という感じで、tasksで定義されているgulpタスクはprojectsフォルダ内であればどこでも使用できます。

## TODO

- HTML等のバリデーションタスク追加
- 画像の圧縮・最適化タスク追加