# Risa/Asirはじめの一歩

MathLibreでRisa/Asirを使い始めるためのガイド。
高山信毅「超入門Cfep/asir (MacOS X)」をもとに、初歩的なコンピュータの知識、MacOS X固有の話を除いたものです。

## 起動

数学ソフトウェア一覧から"Risa/Asir"を選ぶ。
端末窓からはおまじないつき

```
$ openxm fep asir
```

で起動する。

## コマンドライン

Emacs風key bindingが使える。
`^P`上、`^N`下、`^F`右、`^B`左、`^A`行頭、`^E`行末、`^K`カーソルから後ろを消去、など
コマンド入力後、"`;`"+リターンで実行。
`quit;` で終了。

## 簡単な計算

空白（スペース）は適当に入れてよい。

```
2 * ( 3 + 5^4 );
(( 2 + 2/3 ) * 4 + 1/3 ) * 2 + 5;
```

## 定数や初等関数

```
@pi;
eval(@pi);
eval(sin(@pi));
eval(atan(1)) * 4;
eval(@e);
eval(log(@e));
@i^2;
eval(2^(1/2));
```

sqrt(), abs()はない。

## グラフ

グラフの窓の終了は左上のquit.

```
plot(sin(x));
plot(sin(2*x) + 0.5*sin(3*x), [x, -10, 10]);
```

## 変数

変数名は大文字で始める。

```
X = 2;
A = 3;
2 * X^2 + A;
A = 5;
2 * X^2 + A;
```

値が変わったことを確かめよ。

## 多項式

多項式の変数は小文字で始める。
`x2` と書くと変数名になって `x^2` にはならないので注意。

```
(2*x + 3)^4;
(4*x - 2*y^2)^3;
```

`fctr()` で因数分解ができる（有理数係数の範囲）。

```
fctr(x^2 - 1);
fctr(x^3 - 1);
fctr(x^300 - 1);
fctr(x^2 + 2*x*y + y^2);
```

出力結果は一見見にくいが意味はわかるだろう。

## 多項式の定義

この名前も小文字で始める。

```
f(x) := x^2 - 2*x + 1;
f(1);
fctr(f(x));
g(x, y) := x^3 + 3*x^2*y + 3*x*y^2 + y^3;
fctr(g(x, y));
```

## くりかえし

C風のfor文がある。

```
X = 2;
for (I = 1; I < 32; I++) {
    print (X^I);
}
```

## プログラムファイル

適当なファイル（`/home/knoppix/tmp/99.rr` とする)に以下の内容を保存する。

```
for (I = 1; I < 10; I++) {
    for (J = 1; J < 10; J++) {
        print(" "+rtostr(I*J), 0);
    }
    print("");
}
end$
```

ファイルの最後に `end$` を入れることを忘れないように。

注釈：

* 文字列は `+` で結合できる。
* `rtostr()` は数値を文字列に変換する。
* print文の最後の引数に0を指定すると改行しない。

Risa/Asirでこのファイルを実行するには

```
load("tmp/99.rr");
```

よけいな0が出るのは、最後に実行されたprint文の返す値（正常終了）である。

## 実行の中断

終わらない処理をを途中で中断するには`^C`を押す。

```
for (I = 0; I < 10000000; I++)
    print("hello, world");
```

実行中に`^C`を押すと

```
interrupt ?(q/t/c/d/u/w/?)
```

というメッセージが出る。
`?`を押すと説明が出る。
`t`を選べば実行を終わってコマンド入力に戻れる。`c`を選ぶと再開する。`q`を選ぶとRisa/Asirのプログラムが終了する。
他は当面気にしなくてよい。

## 続き

もう少しやってみてもいいかな、という気分になったら

* 高山信毅、野呂正行「Risa/Asirドリル」（Knoppix/Math中にあり）

を参照してAsir使いになってください。

## おまけ

大島先生のお話

* 数式処理（Risa/Asir) と TeX と dviout
* muldif.rr
* [数理談話会『 特殊関数とFuchs型常微分方程式 』](http://www.ms.u-tokyo.ac.jp/video/danwakai/idx_danwa2009.html)（46:10位からRisa/Asirを使った話があります。最後の1:01:40あたりでもひとこと。）
* [日本数学会2010年度年会企画特別講演『特殊関数と代数的線形常微分方程式』](http://mathsoc.jp/meeting/kikaku/2010haru/index.html)（ページの一番下に大島先生の講演の項目があります。ビデオの40:30あたりからRisa/Asirの実演。）
* [Fractional calculus of Weyl algebra and Fuchsian differential equations](https://arxiv.org/abs/1102.2792) (15.11 Okubo and Risa/Asir.)
