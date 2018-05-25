# Unixリダイレクトとパイプ

**必要に応じて、「Linux標準教科書」第4章を参照してください。**

シェルの特徴の一つとして、一つのコマンド行で複数のプログラムの実行を制御したり、プログラムの入出力の行き先を自由につなぎ変えたりできることがあげられます。

一般にプログラムの入出力先として
- 標準入力
- 標準出力
- 標準エラー出力

が定義されていて、コマンドはそれぞれを使い分けています。

コマンドを単体で実行する際には、
- 標準入力はキーボードからの入力
- 標準出力、標準エラー出力は画面への出力

に割り当てられています。

標準出力と標準エラー出力の使い分けについては、すぐ後で見ます。

これらの入出力をファイルに割り当てるには、リダイレクトを用います。
```
コマンド < 入力ファイル
コマンド > 出力ファイル
```
後者では出力ファイルが一旦空にされてからコマンドの標準出力が格納されます。
```
コマンド >> 出力ファイル
```
とすることでファイルへの書き足しが可能になります。
このリダイレクトではいずれも標準出力だけが出力ファイルに書かれるので、標準エラー出力は画面に出力されます。これは次のような場合に便利です。

（実習）次のコマンドを実行し、結果を解釈せよ。
```
$ grep mime /etc/*
$ grep mime /etc/* > ~/grep.out
```
標準エラー出力をリダイレクトすることもできます。標準出力と標準エラー出力を別々のファイルにリダイレクトすることも可能です。

（実習）次のコマンドを実行し、結果を解釈せよ。
```
$ grep mime /etc/* 2> ~/grep.err
$ grep mime /etc/* > ~/grep.all 2>&1
```

（実習）次のコマンドを実行し、結果を解釈せよ。
```
$ echo hello > hello.txt
$ cat hello.txt
$ echo bye > hello.txt
$ cat hello.txt
$ echo byebye >> hello.txt
$ cat hello.txt
```

さらに、あるコマンドの出力を別のコマンドの入力にするには
```
コマンド１ |  コマンド２ | コマンド３
```
のようにつないでいくことができます。これをパイプラインと呼びます。
パイプラインとリダイレクトを混在させることも可能です。

（実習）次のコマンドを実行し、結果を解釈せよ。
```
$ ls /usr | wc -l
```
入出力の接続をせず、単にコマンドを順に実行したい場合は
```
コマンド１ ; コマンド２ ; コマンド３
```
のように、また複数のコマンドを同時に実行したい場合は
```
コマンド１ & コマンド２ & コマンド３
```
のようにします。バックグラウンド実行はこの方法の特別な場合でした。

なお、`()`を使うと複数のコマンドをまとめて（別のシェルで）実行することができます。例えば
```
$ (cd /usr; ls) > ~/usr.out
```
は
```
$ cd /usr; ls > ~/usr.out
```
とは異なった動作になります。

（実習）上記二つのコマンドラインを実行せよ。どこが異なるのか。