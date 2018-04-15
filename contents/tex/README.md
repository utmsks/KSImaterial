このディレクトリにあるのは，
2018年度TeX実習の実習資料です．
* 元々は2014年度TeX実習の実習資料として作成されたものを，
  ちょっとずつ更新して利用しています．

# 受講生向けの情報
受講生は[実習資料](tex_practice.md)を読んで実習を行ってください．

# TA向けの情報
## タイプセット方法
メインとなるファイルは

* `tex_inst.tex`     「TeX Live のインストール」
* `tex_practice.tex` 「TeX 実習」
* `tex_mik.tex`      「pTeX 系列以外による日本語文書作成」
* `tensaku.tex`      「LaTeXレポート添削」

の 4 つです．
それぞれ

* `lualatex tex_inst.tex`
* `lualatex tex_practice.tex`
* `xelatex tex_mik.tex`
* `platex tensaku.tex && dvipdfmx tensaku.dvi` (これは「普通の」やつ)

でタイプセットされます．luajitlatex が利用できる環境ならば，
lualatex よりこちらの方が若干速いです．

## トラブルシューティング
`lualatex`でタイプセットするときに
```
! LaTeX Error: File `xunicode.sty' not found.
```
なるエラーが出た場合は，
`sudo apt install texlive-xetex`
で解決する(かもしれない)
