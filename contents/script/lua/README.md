# Lua入門

## はじめに

Lua は，他プログラムに組み込まれることを目的として作られたスクリプト言語の 1 つです．
文法がとてもシンプルであり，比較的高速に動作すると言われています．

また，非常に軽量であることも面白い点です．（機能の違いもあるのであまり良くない比較ですが）純粋にアーカイブのサイズで見ると，次のようになっています（いずれも 2015/6/28 現在最新の安定版）：

* `Python-3.4.3.tar.gz`: 18.6M
* `perl-5.22.0.tar.gz`: 16.3M
* `ruby-2.2.2.tar.gz`: 15.8M
* `lua-5.3.1.tar.gz`: 276K
  (この実習で使う 5.2 系は `lua-5.2.4.tar.gz`: 247K)


ページの分量が多いので，実習資料自体はいくつかに分割してあります．このページでは，宣伝文句やインストール方法を載せています．

* [最初の例，制御構造，変数のスコープと関数](basic.md)
* [テーブル](table.md)
* [文字列](string.md)

## インストール方法

実習環境の Ubuntu 16.04 LTS には標準でインストールされていないので，自分でインストールする必要があります．
2016/6/16 の時点では，`lua50` (Lua 5.0.3), `lua5.1` (5.1.5), `lua5.2` (5.2.4), `lua5.3` (5.3.1) から選べます．
ここでは Lua 5.2 をインストールします：

```sh
$ sudo apt-get install lua5.2
```

## 参考ページ

いくつか参考になるページを挙げておきます：

* http://www.lua.org/ （Lua 公式ページ）
* http://milkpot.sakura.ne.jp/lua/lua52_manual_ja.html （Lua 5.2 リファレンスの日本語訳）
* http://www.lua.org/pil/contents.html
  解説書 Roberto Ierusalimschy, *Programming in Lua* の初版（Lua 5.0 向け）の内容が公式に公開されています．
* http://lua-users.org/wiki/ (lua-users wiki)

関連したプログラムとして，

* http://luajit.org/ （LuaJIT: Lua の Just-In-Time Compiler．現時点では Lua 5.1 互換）

## おまけ：Luaを組み込んだソフトウエア・ハードウエア

* [LuaTeX](http://www.luatex.org/) （Lua を組み込んだ TeX エンジン）
  * LuaTeX の登場のおかげで，TeX の開発に関わる際には Lua を知っておくと役に立つ……かもしれません．（実際、TeX Liveに付随するいくつかのスクリプトはLuaで書かれています）
* [Vim](http://www.vim.org/)
  * 最近のVimはLuaでマクロが書けるらしいです．
* [Pandoc](http://pandoc.org/)（文書フォーマット変換プログラム）
  * PandocはMarkdown等で書かれた文書を他の形式（HTML, LaTeX等）に変換するプログラムです。Pandoc filterを書くことによって変換処理をカスタマイズできますが、最近Pandoc本体がLuaで書かれたfilterを直接実行できるようになりました。
* [SciTE](http://www.scintilla.org/SciTE.html)（テキストエディタ）
  * Luaでエディタの挙動を拡張できます．
* [ヤマハのルーター](http://www.rtpro.yamaha.co.jp/RT/docs/lua/)
  * Luaが組み込まれているものがあるようです．
* [FlashAir](https://flashair-developers.com/ja/documents/api/lua/)
  * FlashAirは、Wi-Fiを組み込んだSDカードです。Luaでプログラムを書くことにより、SDカードへのファイル書き込み時にWebのAPIを叩いたり、あるいは自作の電子回路に組み込んでSDカードの端子を制御したりできます。
* 各種ゲーム
  * ゲーム用のスクリプトとして採用されていることがあるらしいです．

担当：北川 （2013 年度 計算数学I TA）
改訂：荒田 （2015 年度 計算数学I TA）
