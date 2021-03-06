# 正規表現とsed

正規表現とそれを活用するコマンドの実習を行います。基本的なコマンドの使い方とシェルの機能についての知識を前提とします。

## 始める前に
作業用の材料として[Project Gutenberg](http://www.gutenberg.org)に収録されている[Moby Word Lists](http://www.gutenberg.org/ebooks/3201)に含まれる辞書ファイルを利用します。
（Project Gutenberg, Moby Word List
及びその作者の[Grady Ward](http://www.gutenberg.org/ebooks/author/1132)については自分で調べておいてください。）

以下のファイルを取得し、展開してください。

- [https://www.gutenberg.org/files/3201/files.zip](https://www.gutenberg.org/files/3201/files.zip)
- [https://www.gutenberg.org/files/3201/3201.zip](https://www.gutenberg.org/files/3201/3201.zip)

展開すると`3201.txt`というファイルと`files`というディレクトリができます。
入っているファイルの説明は`3201.txt`（の末尾の方）にあります。

実習には、`COMMON.TXT`に含まれている辞書の見出し語データを用います。
このままでは使いにくいので、次のおまじないを行って整形します。
```
$ sed -e 's/\r$//' -e '/^-/d' -e '/-$/d' files/COMMON.TXT > dict
```
以下の実行例では、整形したデータを上のように`dict`というファイルに入れたものと仮定します。
（このおまじないの意味はsedの項目の後で説明します。）

## grep類
grepについてまず復習します。
```
$ grep variable dict
$ grep -n variable dict
$ grep catenate dict
$ grep Japan dict
$ grep -i Japan dict
$ grep math dict | grep -v mathe
```
grepはこのような単純な文字列だけでなく、一つのパターンが複数の文字列にマッチする複雑な検索もできます。それを可能にするのが正規表現です。

正規表現では、いくつかの特別な意味を持つ「メタキャラクタ」を使います。
```
$ grep ^math dict
$ grep 'math$' dict
$ grep ^catenate dict
$ grep '^.....a$' dict | wc -l
$ grep '^[A-Z]....a$' dict | wc -l
$ grep '^[a-z]....a$' dict | wc -l
$ grep '^[^A-Z]....a$' dict | wc -l                 # 前の行との違いは？
$ grep 'a*' dict
$ grep 'aa*' dict
$ grep 'aaa*' dict                                  # この３行の違いは何か？
```


問　タグ付き正規表現（\\(と\\)）を調べ、grepを使って英語のパリンドローム（前から読んでも後ろから読んでも同じ単語）を探せ。（ヒント：一定の長さの単語ごとにパターンを書くとよいかも。）

## ストリーム・エディタ－sed
エディタといえばvimやemacsのようなものを思い浮かべることと思いますが、作業の自動化・効率化という観点からは、沢山あるデータをいちいち人手をかけずに片付けることが重要です。簡単な場合にこれを行うとき便利なのがsed (stream editor)です。sedは次のように処理を進めます。

1. ファイル（指定がなければ標準入力）から１行読む
1. 与えられたコマンドに対応する処理を行う
1. 結果を表示する
1. １に戻る

書式は
```
$ sed コマンド ファイル...
```
となります。

「コマンド」には沢山の種類があります。ここでは直観的にわかるもの、よく使いそうなものだけを紹介します。

### s (substitute)

例：
```
$ cat wrong.txt
What is taht?
$ sed 's/taht/that/' wrong.txt
What is that?
```
（`wrong.txt`というファイルは用意してありませんが、示されている内容のファイルを自分で作ってください。以下同様）
「コマンド」を `'` でくくっていることに注意してください。上の例では必要ありませんが、正規表現を使うときなど、シェルが勝手に解釈しては困る文字列が出てくることが多いためです。

一行の中で全部変更したい場所がある場合は、次のようにします（どこが違う？）
```
$ cat wrongwrong.txt
What is taht?  Is taht a cat?
$ sed 's/taht/that/' wrongwrong.txt
What is that?  Is taht a cat?
$ sed 's/taht/that/g' wrongwrong.txt
What is that?  Is that a cat?
```
正規表現を使っていろいろなパターンにマッチさせることもできます。
```
$ cat test.txt
a 21
is 10
this 3
$ sed 's/\(.*\)\( \)\(.*\)/\3\2\1/' test.txt
21 a
10 is
3 this
```
このsedのコマンドをどう読むかというと、「入力行を任意の文字列１と、空白の並び２と、また別の任意の文字列３にマッチさせ、その全体を３、２、１の 順につないだものに置き換える」となります。つまり、`\(`と`\)`にはさまれた正規表現に、順に１、２、３と番号がつけられ、それにマッチした部分を置換文字列の中で"`\番号`"として参照できるわけです。なお、"`.*`"という正規表現が任意の文字(.)とその０個以上の連続つまり任意の文字列となることに注意してください。

こういう置き換えを複数やりたい（コマンドを複数与えたい）場合は、
```
$ sed -e 's/Thsi/This/g' -e 's/Taht/That/g' wrong2.txt
```
のようにオプション`-e`を使って書き並べるか、
```
$ cat cmds.sed
s/Thsi/This/g
s/Taht/That/g
$ sed -f cmds.sed wrong2.txt
```
のようにファイルにコマンドをおさめておいて（このときはシェルが介在しないので`'`は不要）`-f`オプションで参照すればできます。
### d (delete)
行を消去します。sコマンドのところでは説明しませんでしたが、コマンド文字の前に数字を与え、処理の範囲を行単位で指定することができます。
```
$ head -3 dict
3-D
A
A & R
$ sed 1d dict | head -3
A
A & R
A battery
$  sed 1,3d dict | head -3
A battery
A horizon
A number 1
```
何がおこっているか、わかったでしょうか？コマンド文字の前に数字を一つだけ書くと、その行にのみ処理が行われ、コマンド文字の前に,で区切って二つの文字を書くと、その範囲の行が処理対象となるわけです。何も書かないと、すべての行が対象になります。特別な記号として、$は最後の行の意味になります。範囲を正規表現によって指定することもできます。
```
$ head -3 dict
3-D
A
A & R
$ sed '/^[0-9]/d' dict | head -3
A
A & R
A battery
$ sed '/^A/,/^C/d' dict | head -3
3-D
C battery
C clef
```

問　空行（スペースやタブのような見えない文字も含め、何もない行）を削除するには？ヒント：`^`, `$`.

### p (print)
sedは処理を行った後の行を表示するのが普通の動作ですが、`-n`オプションを与えるとそれが抑止されます。このとき、特に行の表示を行うのが`p`コマンド です。他のコマンドとあわせて使うこともできます。
```
$ sed -n 1,3p dict
3-D
A
A & R
$ sed -n 's/A/@/p' dict | head -3
@
@ & R
@ battery
```
一つ目の例は、"`head -3`"と同じですね。ただし、一応ファイルの最後まで調べてから終了するので、ちょっとよけいに時間がかかります（試してみてください）。
### q (quit)
"`head -3`"と同じことをするもう一つの方法はqコマンドを使うことです。
```
$ sed 3q dict
3-D
A
A & R
```
こちらは、３行表示してすぐ終了します。

問　"`head -3`"と同じ動作をさせる方法をもう一つ考えてください。

sedのコマンドは他にもいくつかあり、trickyなプログラムも書けます。興味ある人はマニュアルページで調べてください。

### 冒頭のおまじないの説明
実習の準備の時に行ったおまじないについて説明しておきます。
説明のため、改行を行い、行番号をつけておきます。

```
 1: $ sed \
 2:   -e 's/\r$//' \
 3:   -e '/^-/d' -e '/-$/d' \
 4:   files/COMMONS.TXT > dict
```
2行目では改行コードを調整しています。
詳しく知りたい人は「改行コード」"CR LF"を検索してみてください。
（なおメタキャラクタ'`\r`'はGNU sedの拡張仕様です。
Linuxではこのまま使えますが、macOSなどでは
GNU sedをインストールする必要があります。）

3行目では、接頭辞・接尾辞を除去しています。
元々の`COMMONS.TXT`と比べてみてください。
（単に`$ diff files/COMMONS.TXT dict`とするとダメです。なぜ？）


## 課題
dictを使って、次のことを調べてください。
（簡単にできるとは限りません。）
- 末尾がtion, tiveで終わる単語はそれぞれ何個あるでしょうか。
- tion, tiveを含むが、これらが末尾にない単語はそれぞれ何個あるでしょうか。
- 一番長い単語は何でしょうか。
- 長さが1文字、2文字、、、の単語はそれぞれいくつあるかの表を作ってください。
- 一番多くの母音を含む単語は何でしょうか。
- 一番長い連続した母音列を含む単語は何でしょうか。

## 文献
正規表現を究めたい人には
- Jeffrey E. F. Friedl, 『詳説　正規表現　第３版』（オライリー・ジャパン、2008年）
- Jan Goyvaerts, Steven Levithan., 『正規表現クックブック』（オライリー・ジャパン、2010年）
- 新屋良麿、鈴木勇介、高田謙、『正規表現技術入門』（技術評論社、2015年）
- 佐藤竜一、『正規表現辞典　改訂新版』（翔泳社、2018年）

をおすすめします。

正規表現は元々オートマトンや（情報科学としての）言語の理論の基礎になっています。
上に挙げた文献にはそれぞれ解説があります。
興味のある人は調べてみてください。

sedについては
- Dale Dougherty and Arnold Robbins, 『sed & awkプログラミング（改訂版）』（オライリー・ジャパン、1997年）

ちょっと毛色の変わったものとして次の本をあげておきます。ややマイナーな（怒られるかな）文系出版社の編集者（社長ですが）が編み出した原稿の表記の統一などにsedを駆使する方法が書かれています。
- 西村能英、『出版のためのテキスト実践技法［総集篇］』（未来社、2009年）

sedではちょっと実現しにくいより複雑な作業には、awk（どうしてこんな名前？）を使うと便利なことがあります。私（一井）はこれが好きで、時々使っています。awkについては
- A. V. K. エイホ他、『プログラミング言語AWK』（新紀元社、2004年）（トッパン1989年刊の再刊）

が作者らによる定本です。
『sed & awkプログラミング（改訂版）』にも解説があります。

このページを作成するにあたっては
- Brian W. Kernighan & Rob Pike,『UNIXプログラミング環境』（アスキー出版局、1985年）
- 久野靖、『UNIXによる計算機科学入門（改訂２版）』（丸善、2004年）
- 山口和紀＋古瀬一隆監修、『新The UNIX Super Text 【上】』（技術評論社、2003年）
- 佐藤竜一、『正規表現辞典　改訂新版』（翔泳社、2018年）

を参考にしました。
