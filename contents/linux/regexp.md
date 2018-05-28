# 正規表現とsed

正規表現とそれを活用するコマンドの実習を行います。基本的なコマンドの使い方とシェルの機能についての知識を前提とします。

## 始める前に
**辞書ファイル変更予定**
作業用の材料としてGNU miscfilesに含まれる辞書ファイルを利用します。各自のホームディレクトリの下に適当な名前の作業用ディレクトリを作り、そこに次のリンク先（204号室実習用ネットワーク内からのみ）にあるmiscfileパッケージ(miscfiles-1.5.tar.gz)をダウンロード・展開してください。
ftp://download.ks.prv/mirror/Text/miscfiles-1.5.tar.gz
展開の仕方がわからない人は `$ man tar` またはTAへ。
miscfilesパッケージはFree Software FoundationのGNUプロジェクトで配布されています。詳細は http://directory.fsf.org/project/miscfiles/ を参照。
展開後、その中に何が入っていたかを確認しておくこと。また、 README, ORIGIN, dict-READMEに目を通し、web2, web2aの内容をざっと見ておいてください。

問　"web"と言ってもWorld Wide Webのことではありません。ではいったい何のこと？

## grep類
grepについてまず復習します。
```
$ cd miscfiles-1.5
$ grep variable web2
$ grep -n variable web2
$ grep catenate web2
$ grep Japan web2
$ grep -i Japan web2
$ grep math web2 | grep -v mathe
```
grepはこのような単純な文字列だけでなく、一つのパターンが複数の文字列にマッチする複雑な検索もできます。それを可能にするのが正規表現です。

正規表現では、いくつかの特別な意味を持つ「メタキャラクタ」を使います。
```
$ grep ^math web2
$ grep 'math$' web2
$ grep ^catenate web2
$ grep '^.....a$' web2 | wc -l
$ grep '^[A-Z]....a$' web2 | wc -l
$ grep '^[a-z]....a$' web2 | wc -l
$ grep '^[^A-Z]....a$' web2 | wc -l                 # 前の行との違いは？
$ grep 'a*' web2
$ grep 'aa*' web2
$ grep 'aaa*' web2                                  # この３行の違いは何か？
```


問　タグ付き正規表現（\\(と\\)）を調べ、grepを使って英語のパリンドローム（前から読んでも後ろから読んでも同じ単語）を探せ。（ヒント：一定の長さの単語ごとにパターンを書くとよいかも。）

## ストリーム・エディタ－sed
エディタといえばvimやemacsのようなものを思い浮かべるかもしれませんが、作業の自動化・効率化という観点からは、沢山あるデータをいちいち人手をかけずに片付けることが重要です。簡単な場合にこれを行うとき便利なのがsed (stream editor)です。sedは次のように処理を進めます。
```
ファイル（指定がなければ標準入力）から１行読む
与えられたコマンドに対応する処理を行う
結果を表示する
１に戻る
```
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
このsedのコマンドをどう読むかというと、「入力行を任意の文字列１と、空白の並び２と、また別の任意の文字列３にマッチさせ、その全体を３、２、１の 順につないだものに置き換える」となります。つまり、`\(`と`\)`にはさまれた正規表現に、順に１、２、３と番号がつけられ、それにマッチした部分を置換文 字列の中で"`\番号`"として参照できるわけです。なお、"`.*`"という正規表現が任意の文字(.)とその０個以上の連続つまり任意の文字列となることに注意してください。

こういう置き換えを複数やりたい（コマンドを複数与えたい）場合は、
```
$ sed -e 's/Thsi/This/g' -e 's/Taht/That/g' wrong2.txt
```
のようにオプション-eを使って書き並べるか、
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
$ head -3 web2
A
a
aa
$ sed 1d web2 | head -3
a
aa
aal
$  sed 1,3d web2 | head -3
aal
aalii
aam
```
何がおこっているか、わかったでしょうか？コマンド文字の前に数字を一つだけ書くと、その行にのみ処理が行われ、コマンド文字の前に,で区切って二つの文字を書くと、その範囲の行が処理対象となる訳です。何も書かないと、すべての行が対象になります。特別な記号として、$は最後の行の意味になります。範囲を正規表現によって指定することもできます。
```
$ head -3 airport
# Airport Code:Airport:Country Code:Geographic subdivision:Major city or cities serving
AAL:Aalborg:DK::Aalborg
AAR:Aarhus:DK::Aarhus
$ sed '/^#/d' airport | head -3
AAL:Aalborg:DK::Aalborg
AAR:Aarhus:DK::Aarhus
ABD:Abadan:IR::Abadan
$ sed '/^A/,/^C/d' airport | head -3
# Airport Code:Airport:Country Code:Geographic subdivision:Major city or cities serving
CAG:Cagliari Elmas:IT::Cagliari
CAI:Cairo International:EG::Cairo
```

問　空行（スペースやタブのような見えない文字も含め、何もない行）を削除するには？ヒント：`^`, `$`.
### p (print)
sedは処理を行った後の行を表示するのが普通の動作ですが、-nオプションを与えるとそれが抑止されます。このとき、特に行の表示を行うのがpコマンド です。他のコマンドとあわせて使うこともできます。
```
$ sed -n 1,3p web2
A
a
aa
$ sed -n 's/A/@/p' web2 | head -3
@
@ani
@aron
```
一つ目の例は、"`head -3`"と同じですね。ただし、一応ファイルの最後まで調べてから終了するので、ちょっとよけいに時間がかかります（試してみてください）。
### q (quit)
"`head -3`"と同じことをするもう一つの方法はqコマンドを使うことです。
```
$ sed 3q web2
A
a
aa
```
こちらは、３行表示してすぐ終了します。

問　"`head -3`"と同じ動作をさせる方法をもう一つ考えてください。

sedのコマンドは他にもいくつかあり、trickyなプログラムも書けます。興味ある人はマニュアルページで調べてください。

課題
web2を使って、次のことを調べてください。
末尾がtion, tiveで終わる単語はそれぞれ何個あるでしょうか。
tion, tiveを含むが、これらが末尾にない単語はそれぞれ何個あるでしょうか。
一番長い単語は何でしょうか。
長さが1文字、2文字、、、の単語はそれぞれいくつあるかの表を作ってください。
一番多くの母音を含む単語は何でしょうか。
一番長い連続した母音列を含む単語は何でしょうか。

## 文献
正規表現を究めたい人には
- Jeffrey E. F. Friedl, 『詳説　正規表現　第３版』（オライリー・ジャパン、2008年）
- Jan Goyvaerts, Steven Levithan., 『正規表現クックブック』（オライリー・ジャパン、2010年）
- 新屋良麿、鈴木勇介、高田謙、『正規表現技術入門』（技術評論社、2015年）

をおすすめします。

なお、正規表現は元々オートマトンや（情報科学としての）言語の理論の基礎になっています。そのほんのさわり（たった１ページ分ですが）が
- 山口和紀＋古瀬一隆監修、『新The UNIX Super Text 【上】』（技術評論社、2003年）

にも書かれています。この本は計算機室の本棚に常備してあります。何でも書いてあって本格的にUnixを使うにはあると便利な本ですが、上下あわせると厚すぎるほか、相当に説教臭く、刊行からかなり時間が経ち、古めかしい部分もあります（歴史的な蘊蓄を味わうための本ともいうべきか）。

sedについては
- Dale Dougherty and Arnold Robbins, 『sed & awkプログラミング（改訂版）』（オライリー・ジャパン、1997年）

また、ちょっと毛色の変わったものとして次の本をあげておきます。ややマイナーな（怒られるかな）文系出版社の編集者（社長ですが）が編み出した原稿の表記の統一などにsedを駆使する方法が書かれています。
- 西村能英、『出版のためのテキスト実践技法［総集篇］』（未来社、2009年）

sedではちょっと実現しにくいより高度な作業には、awk（どうしてこんな名前？）を使うと便利なことがあります。私（一井）はこれが好きで、よく使っています。awkについては、上記の本の他
- A. V. K. エイホ他、『プログラミング言語AWK』（新紀元社、2004年）（トッパン1989年刊の再刊）

が作者らによる定本です。

このページを作成するにあたっては
- Brian W. Kernighan & Rob Pike,『UNIXプログラミング環境』（アスキー出版局、1985年）
- 久野靖、『UNIXによる計算機科学入門（改訂２版）』（丸善、2004年）
- 山口和紀＋古瀬一隆監修、『新The UNIX Super Text 【上】』（技術評論社、2003年）

を参考にしました。
