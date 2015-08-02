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
Windows用,Mac用それぞれのサンプルとして`config.js.win-example`と`config.js.mac-example`を用意しているので適宜 拡張子を変更して使用してください。

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

*To Be Continued...*
