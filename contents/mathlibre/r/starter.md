# R Starter

## Rとは何か

Rは統計計算を効率的に行うことを目的に開発されたソフトウェアである。

Octaveが商品であるMatlabを参照していたように、Rはベル研で開発されその後商品化されたSという統計計算パッケージをモデルとしている。
そのため、コマンドの文法などはきわめてよく似ていて、Sの参考書やライブラリをほぼそのまま使うことができる。
最初からRを対象とした統計学の教科書なども多数ある。

以下で見るように、統計学以外にもいろいろ役立てることができる。おすすめソフトウェアの一つである。

## Rを使うために

MathLibreには既にRが含まれているのでインストール作業は特に必要ない。

ターミナルウインドウを開き、コマンドラインで

```
$ R
```

と入力すると起動する。（大文字に注意）
いつものMathメニューにはGUI付きの"R Commander"というソフトウェアが含まれているが、操作方法が多少違うので注意。

http://cran.r-project.org/ にはいろいろなLinux, Mac及びWindows用のバイナリもある。
（実際にファイルを取ってくるときは近くのミラーサイトを利用するのがよい。）

## Rの起動と終了

Rが起動すると、クレジットなどが表示された後、

```
>
```

というプロンプトが出る。

終了するには、プロンプトに対して

```r
> q()
```

を入力してリターンを押す。
すると、"Save workspace image?"と作業中の変数等の情報を保存するかどうか聞いてくる。今のところは"n"を選べばよい。

## 入力上の注意

* 大文字と小文字は区別される。
* 変数等の名前には、アルファベット、数字、"`.`"（ピリオド）、"`_`"（アンダースコア）が使える。ただし、先頭はアルファベットまたはピリオド（ピリオドで始まる場合二文字目は数字ではいけない）という制約がある。
* 入力はリターンまたは"`;`"（セミコロン）で区切られる。つまりセミコロンを使うと一行に複数のコマンドが書ける。
* "`#`"から後はコメント。
* 入力中は上向き矢印キーで過去のコマンドを呼び出す等の編集機能が使える。

## 電卓

基本的な初等関数などはそろっているので、関数電卓として利用できる。

```r
> 1 + 2
[1] 3                   # 答えが表示される（"[1]"については後述）
> 1+2              　  　# くっつけて書いてもOK
[1] 3
> pi
[1] 3.141593            # 内部では倍精度で表現されている
> sin(pi/2)
[1] 1
> log(exp(1))
[1] 1
> a <- 10000000              # 代入は <-, 結果が表示されないことに注意
> b <- 20000000
> c <- a * b
> c                                     # 変数の値の表示
[1] 2e+14
> a / b -> d                       # -> でも代入できる
> d
[1] 0.5
> ls()                            # 定義したオブジェクト（変数、関数等）を表示
[1] "a" "b" "c" "d"
```

ここまでやったところで、一旦Rを終了し（ただし、今度は"Save workspace image?"に対し"y"とする）、再度Rを起動してみよ。
そのとき、

```r
> ls()
```

を実行するとどうなるか。

## ベクトル

Rはデータ処理を得意とする言語であり、データの並びをまとめて処理するためのデータ構造を持っている。
これをベクトルと呼び、次のように扱う。

```r
> x <- c(10.4, 5.6, 3.1, 6.4, 21.7)     # ベクトルは"c"というコマンドで作ることができる
> x
[1] 10.4  5.6  3.1  6.4 21.7                # 確認
> x + 1                                       # 各要素ごとに演算を行なう
[1] 11.4  6.6  4.1  7.4 22.7
> x * 10                                      # 同上
[1] 104  56  31  64 217
> 1/x                                          # 同上
[1] 0.09615385 0.17857143 0.32258065 0.15625000 0.04608295
> y <- c(5.2, 1.9, 4.2, 29.4, 0.1)    # 別のベクトル
> x + y
[1] 15.6  7.5  7.3 35.8 21.8        # やはり要素ごとに演算する
> x * y
[1]  54.08  10.64  13.02 188.16   2.17   # 同上
> log(y)                        # こんなことや
[1]  1.6486586  0.6418539  1.4350845  3.3809947 -2.3025851
> x^2 + y^3                # こんなことも("^"はべき）
[1]   248.768    38.219    83.698 25453.144   470.891
> length(x)
[1] 5                           # ベクトルの長さは要素の個数
> sort(x)
[1]  3.1  5.6  6.4 10.4 21.7    # 並べ替え
> 1:5                # これと
[1] 1 2 3 4 5
> c(1,2,3,4,5)    # これは同じ
[1] 1 2 3 4 5
```

最後のように規則正しい列をより一般に作るには`seq()`という関数が使える。

```r
> ?seq
```

または

```r
> help(seq)
```

によって使い方を調べること。
（関数名がわかっている場合、このようにしてヘルプを参照することができる。
他の関数についても参照してみよ。）

ただし、やりたいことがあるのだけれどどうすれば良いのかわからない、等という場合にヘルプシステムはあまり親切でない。このときは、Web（[R For Further Study](further-study.md)参照）にたくさんの情報があるので、こちらを参照するのがよい。

なお、Rの関数の引数は、順序によって指定する他、名前によって指定することもできる。
すなわち、

```r
> seq(0, 10, 2)
```

は

```r
>seq(from=0, to=10, by=2)
```

と同じであり、かつ

```r
>seq(by=2, from=0, to=10)
```

とも同じである。名前によって指定した場合、順序は無関係になる。

ベクトルの要素を取り出すこともできる。

```r
> x[1]                # 1番目
[1] 10.4
> x[2]               # 2番目
[1] 5.6
> x[2:4]            # 2番目から4番目
[1] 5.6 3.1 6.4
> x[4:2]           # 逆順
[1] 6.4 3.1 5.6
> x[-(2:4)]       # 2番目から4番目を除く
[1] 10.4 21.7
```

条件によって要素を選択することもできる。

```r
> z <- c(1.2, -2.3, 0.3, 5.4, -2.7, -9.2)  # 負の要素を含む
> z[z < 0]                # 負の要素だけを選ぶ
[1] -2.3 -2.7 -9.2
> z -> zz
> z[z < 0] <- -z[z < 0]    # これは何をしている？
> z
[1] 1.2 2.3 0.3 5.4 2.7 9.2
> abs(zz)           # これと同じであった
[1] 1.2 2.3 0.3 5.4 2.7 9.2
```

## 変数のモード

変数には

* numeric (integerとdoubleをまとめて扱う)
* logical (TRUE or FALSE)
* complex
* character

のモード（型のようなもの）がある。
モードを判定する関数`is.numeric()`などがある。

```r
> is.numeric(x)
[1] TRUE
> is.logical(x)
[1] FALSE
```

問：次の違いはなにか。

```r
> sqrt(-1)
> sqrt(-1+0i)
```

ヒント：NaN = "Not a Number", 数学的に定義されない演算を行なった場合を表す

## for文

Rではできるだけベクトル処理をするのがよい（高性能だしプログラムも短くなる）が、
逐次処理もできる。
次の例を実行し、出力の意味を考えよ。

```r
> for (i in 0:10) { print(outer(i, 0:i, "choose")) }
```

ヒント：outer, chooseが何かは、それぞれヘルプで調べるとよい。

---

次は、[R Matrix](matrix.md)に進んでください。