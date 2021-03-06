# Ruby ― 基本編 I

## 諸注意

ある程度習熟した人がまとまったプログラムを書く場合は ruby を使った方がデメリットが少ないのですが、ここでは初心者の学習に適した irb を使います。

以下では、入力する命令の前に表示される `irb(main):***:*` の部分は省略してあります。
また、一部の実行結果で、説明に用いない出力 (`=>` から始まる行) を省略している場合があります。

## 基本的な演算

対話型の処理系の良いところは、入力した値がすぐ次の行に出力されることです。
試しに `0` と入力してみましょう。

```ruby
> 0
=> 0
```

入力した `0` がそのまま表示されています。
しかし、これは入力した数そのものではなく、入力を計算した結果なのです。
したがって、計算式を入力すれば計算結果が出力されます。
かけ算には `*` を使い、わり算には `/` を使うことに注意してください。
また、わり算の余りは `%` で、冪乗は `**` で計算できます。

```ruby
> 6 + 2   # たし算
=> 8
> 6 - 2   # ひき算
=> 4
> 6 * 2   # かけ算
=> 12
> 6 / 2   # わり算
=> 3
> 6 % 2   # わり算の余り
=> 0
> 6 ** 2  # 冪乗
=> 36
```

`#` 以降は「コメント」と呼ばれるもので、実行時に無視されます。
この資料では、その行でどんな処理をしているかの説明をするために用いていますが、実行結果には関与しないので、実際に入力する必要はありません。

`Math.sqrt(3)` のようにすると平方根を計算できます。

```ruby
> Math.sqrt(3)  # 3 の平方根
=> 1.7320508075688772
> Math.sqrt(4)  # 4 の平方根
=> 2.0
```

# 数値型

次の 2 つの計算結果を見比べてみましょう。

```ruby
> 7 / 2
=> 3
> 7.0 / 2
=> 3.5
```

上で見た通り、`/` はわり算の演算子です。
ご存知のように 7 ÷ 2 の答えは 3.5 なので、下の結果がより厳密であり、上の結果はその整数部分しか現れていません。
これは 7 の表記が `7` なのか `7.0` なのかによるものです。

Ruby には数値を表す型として、整数 (`Integer` と呼ぶ) と浮動小数点数 (`Float` と呼ぶ) の 2 種類が主に用意されています。
Ruby では、小数点なしで数字を並べた場合は整数だと解釈され、小数点があると浮動小数点数だと解釈されます。

整数同士の演算では、整数が出力されることになっています。
演算をする数値の一方に浮動小数点数が混ざっている場合は、浮動小数点数が出力されます。
したがって、整数 `7` を整数 `2` でわった結果は、その値を整数にするため小数部分が切り捨てられて `3` となります。
一方、浮動小数点数 `7.0` を整数 `2` でわった結果は、浮動小数点数で良いので `3.5` となるのです。

7 ÷ 2 という計算を浮動小数点数の世界でする方法には、7 を `7.0` と表記する他に、整数の `7` を浮動小数点数に変換するという方法もあります。
そのためには、整数の後に `.to_f` と書きます。

```ruby
> 7.to_f / 2
=> 3.5
```

なお、`Math.sqrt` が返す平方根の値は常に浮動小数点数です。

## 演習問題 1

以下の計算を Ruby でしてください。
わり算を含むものは、整数の範囲ではなく小数の範囲で計算してください。

* 4972 − (−6236 + 4720)
* 52 ÷ (153 ÷ 100)<sup>2</sup>
* 1 + 2 × 3<sup>4</sup> − (5 × 6 + 7)
* (63 × (17 + 15√5)) ÷ (25 × (7 + 15√5))
* 2<sup>64</sup> + 3<sup>18</sup>

解答は[こちら](basic1_answer.md)。

## 演習問題 2

以下の式はそれぞれどんな値を返すでしょうか。
当然実際に実行してみれば分かりますが、その前に予想してみるとおもしろいかもしれません。

```ruby
> (-19) / 5
> 19 / (-5)
> (-19) / (-5)
> (-19) % 5
> 19 % (-5)
> (-19) % (-5)
```

解答は[こちら](basic1_answer.md)。

## 文字列

Ruby では文字列を簡単に処理することができます。
これが Ruby の強みでもあります。

文字列は `"` で囲んで表現します。

```ruby
> "abc"
=> "abc"
```

演算子 `+` を用いることで、文字列の結合を行います。

```ruby
> "abc" + "def"
=> "abcdef"
```

数値を文字列にする場合は数値の後ろに `.to_s` を付け、文字列を数値にする場合は文字列の後ろに `.to_i` (整数にする場合) や `.to_f` (浮動小数点数にする場合) を付けます。

```ruby
> (6 + 7).to_s
=> "13"
> "123.5".to_i  # 整数に変換するため小数部は無視される
=> 123
> "123.5".to_f
=> 123.5
```

Ruby では、文字列と数値を `+` で繋げることはできません。
例えば、以下の実行結果はともにエラーとなります。

```ruby
> 3 + "2"
> "3" + 2
```
このエラーを回避するには、 文字列化の `.to_s` や数値化の `.to_i`, `.to_f` などを用いて、 `+` の前後で値の種類を合わせる必要があります。

```ruby
> 3 + "2".to_i  # 数値にして計算
=> 5
> 3.to_s + "2"  # 文字列にして結合
=> "32"
```

## 真偽値

プログラミングで登場する値には、整数, 浮動小数点数, 文字列以外にも真偽値があります。
真偽値は `true` と `false` の 2 つの値からなります。
`true` と `false` は予約語であるため、これらを変数名として用いることはできません。
これは `1` や `2` のような数字が変数として利用できないのと同じことと考えていただければ分かりやすいと思います。

真偽値の演算には、and (`&&`), or (`||`), not (`!`) などがあります。

```ruby
> true && false  # and
=> false
> true || false  # or
=> true
> !true          # not
=> false
```

Ruby では真偽値も整数などと同様に変数の中に入れることができます。

```ruby
> a = true
=> true
> a || false
=> true
```

簡単な命題の真偽を値として取り出すことができます。
プログラミングにおいては、*x* についての条件 *P*(*x*) は *x* を引数として真偽値を返す関数と見なします。
すなわち、「命題 2 > 1 は真である」という数学における文章は、プログラミング的には「2 変数関数 `>` に `2` と `1` を渡したら `true` が返ってくる」と解釈されるわけです。

```ruby
> 2 == 1  # 等しい
=> false
> 2 != 1  # 等しくない
=> true
> 2 > 1   # 不等号
=> true
> 2 >= 1  # ≧
=> true
```

ここで注意すべきことは、等号は `==` で表すのであって `=` ではないということです。
プログラミングでは、変数への代入と等号は厳密に区別されます。
代入 `=` は「第 1 引数として指定された変数に第 2 引数を代入してから代入した値を返す」関数であり、等号 `==` は「第 1 引数と第 2 引数が同じ値かを判定してその真偽値を返す」関数であって、両者は全く違う働きをしているからです。

## 値の表示

Ruby では、`p` に続けて何らかの式を書くと、その式の計算結果が表示されます。
irb では入力した命令がその都度実行されてその結果が表示されるので、irb だけ使っている分には使う機会があまりないかもしれませんが、繰り返しの途中などで変数の値を確認したいときなどには便利です。

```ruby
> p 3 + 8
11
=> 11
```
`11` が 2 回出力されていますが、最初の `11` は `p` によって出力されたもので、次の `11` は `p 3 + 8` という命令全体の実行結果です。

変数の中身も表示できます。

```ruby
> var = "hello"
=> "hello"
> p var
"hello"
=> "hello"
```

## 条件分岐

真偽値によってプログラムの進行を変えることができます。

下のプログラムでは、`if` の後に書いてある値が真 (`true`) の場合は `end` までの命令が実行され、`if` の後に書いてある値が偽 (`false`) の場合は `if` から `end` までの命令が無視されています。

```ruby
> a = 1
=> 1
> if a == 1  # a == 1 なので問題なく実行される
>   p "a is 1"
> end
"a is 1"
=> "a is 1"
> if a == 2  # a == 2 ではないので中身は無視される
>   p "a is 2"
> end
=> nil
```

極論、これだけ知っていれば条件分岐を用いた「正しい」プログラムは書けます。
しかし、よく使うような処理にはあらかじめ命令が用意されているものです。
`if` に関しては、`else` や `elsif` などが用意されており、以下のように条件に合致しなかった場合などの処理を同時に書くことができます。

```ruby
> a = 2
=> 2
> if a == 1         # もし a == 1 だったら
>   p "a is 1"
> else              # もし a == 1 ではなかったら
>   p "a is not 1"
> end
"a is not 1"
=> "a is not 1"
> b = 2
=> 2
> if a == 1                 # もし a == 1 だったら
>   p "a is 1"
> elsif b == 2              # もし a == 1 ではない上に b == 2 だったら
>   p "a is not 1, b is 2"
> else                      # もし上の 2 つのどちらでもなかったら
>   p "otherwise"
> end
"a is not 1, b is 2"
=> "a is not 1, b is 2"
```
条件分岐については他にも `unless` や `case` といったものが存在しますが、ここでは省略します。
各自調べてみましょう。

## 繰り返し

例えば、1 から 10 までの数字をたしていく操作をする場合、単に 1 + 2 + 3 + … とやっていては書くのが大変です。
こういう場合、繰り返しの構文が使えます。

```ruby
> a = 0
=> 0
> for i in 1..10  # i に 1 から 10 までの数を代入する
>   a = a + i
> end
=> 1..10
> a
=> 55
```
この場合、`for` から `end` までの命令が、 変数 `i` に 1 から 10 までの数を順に代入しながら 10 回繰り返されます。

本当にそうなっているか `p` を用いて確かめてみましょう。

```ruby
> for i in 1..10  # i に 1 から 10 までの数を代入する
>   p i           # i の値を出力
> end
1
2
3
4
5
6
7
8
9
10
=> 1..10
```
繰り返しの命令には `for` の他に `while` も存在します。
こちらは、`while` の直後に書いた式の値が真の間、`end` までに書かれた処理を続けます。

```ruby
> a = 0
=> 0
> i = 0
=> 0
> while i < 100  # i が 100 未満の間続ける
>   i = i + 1
>   a = a + i
> end
=> nil
> a
=> 5050
```

繰り返しから抜けたい場合は `break` と書きます。

```ruby
> a = 0
=> 0
> b = 0
=> 0
> while true
>   a = 1
>   break
>   b = 1
> end
=> nil
> a
=> 1
> b  # break の後の b = 2 が飛ばされている
=> 0
```

## 演習問題 3

上で `for` を用いた繰り返しをしたときに、変数に順に代入していく値の範囲を `1..10` のように書きました。
この `..` は範囲を表す演算子なのですが、同じような演算子に `...` (ピリオド 3 つ) というものもあります。
`..` と `...` は何が違うのでしょうか。
例えば以下を実行するなどして調べてみましょう。

```ruby
> for i in 1..10
>   p i
> end
> for i in 1...10
>   p i
> end
```

解答は[こちら](basic1_answer.md)。

## 演習問題 4

84697 は素数でしょうか。
適切なプログラムを書いて Ruby で確かめてください。

解答は[こちら](basic1_answer.md)。

## 配列

いくつかの変数をまとめて扱いたい場合があります。
例えば、学校などでクラスの成績や特徴を管理する場合、クラス全員をバラバラに覚えておくより、出席番号順にまとめて整理した方が断然効率が良いです。
そのようなことは配列を用いれば簡単にできます。

配列は、まとめたい値を `,` で区切って `[` と `]` で囲んで表現します。

```ruby
> names = ["Tanimura", "Ohori", "Takahashi"]
=> ["Tanimura", "Ohori", "Takahashi"]
> majors = ["geometry", "algebra", "analysis"]
=> ["geometry", "algebra", "analysis"]
```

配列の中の値を参照したい場合は、 例えば 0 番目を取得したければ配列 (もしくはそれを代入した変数) の後に `[0]` と書きます。
注意すべき点は、一番最初の要素が 0 番目であることです。
Ruby では、数は 0 から数えます。

```ruby
> names[0]  # 0 番目 (最初の要素) 参照
=> "Tanimura"
> majors[0]
=> "geometry"
``` 

こうしておけば、0 番は谷村で専門が幾何であることが直ちにわかります。
逆に、例えば大堀の番号が知りたい場合には、ループを回して検索すれば分かります。

```ruby
> for i in 0..2
>   if names[i] == "Ohori"
>     break
>   end
> end
=> nil
> i
=> 1
```

ところで、これではループ範囲を 0 から 2 までと決め打ちしてしまっているので、これでは管理する人が増えて配列の長さが変わってしまった場合、ループ範囲も書き直す必要があって面倒です。
配列の後に `.length` と書くとその配列の要素の数を取得できるので、これを用いて以下のように書いた方が、配列の要素数を気にしなくても良くなるので、より良いでしょう。

```ruby
> for i in 0...(names.length)   # ここでは name.length == 3 なので 0...3 と等価
>   if names[i] == "Ohori"
>     break
>   end
> end
=> nil
> i
=> 1
```

さて、人の名前を管理するにあたって、アルファベット順の方が何かと扱いやすいでしょう。
そこで、名前を管理している配列 `names` をアルファベット順にソートしてみましょう。
Ruby では、次を実行するだけでソートできます。

```ruby
> names = names.sort
```

Ruby では、文字列に対しては辞書式順序で大小関係が定義されているため、これだけで思った通りのソートができます。

さて、実はこれでは問題があります。
`names` の順番だけをソートして大堀, 高橋, 谷村にしてしまうと、`majors` との対応がずれてしまい、これを是正するには大変な面倒が生じてしまいます。
大堀くんに幾何学を、高橋くんに代数学を、谷村くんに解析学を勉強させるのも 1 つの手ですが、そんなことをしなくても次のようにすれば全てが解決します。

```ruby
> students = []
> students[0] = ["Tanimura", "geometry"]   # students の 0 番目の要素として ["Tanimura", "geometry"] を代入
> students[1] = ["Ohori", "algebra"]       # 以下同様
> students[2] = ["Takahashi", "analysis"]
> students = students.sort
```

このように配列を二重構造にすればいいのです。
この場合、1 番の人の専門だけが知りたい場合には、以下のようにすれば良いです。

``` ruby
> students[1][1]
=> "analysis"
```

配列には `length` や `sort` の他にも便利な関数がたくさん用意されています。
リファレンスマニュアルなどを利用して調べてみましょう。

## 演習問題 5

`array` という名前の変数に配列が代入されているとき、`array[0]` とすればその最初の要素を取得できることが分かりました。
では、次のコードは何を出力するでしょうか。

```ruby
> array = ["first", "second", "third", "fourth"]
> array[-1]
```

`-1` の代わりに `-2` などとするとどうなるでしょうか。

解答は[こちら](basic1_answer.md)。

## 演習問題 6

`fruits` という名前の 6 要素から成る配列があります。
例えば以下のようなものです。

```ruby
> fruits = ["apple", "orange", "banana", "peach", "grape", "lemon"]
```

次の処理を順番に行ってください。

* `fruits` の最後の要素を `"strawberry"` に変更する
* `fruits` の 2 番目と 3 番目 (最初の要素を 0 番目とする) の間に `"melon"` という要素を挿入する
* `fruits` から `"orange"` という要素を削除する
* `fruits` の要素を逆順に並べた配列を新たに作り、`new_fruits` という名前の変数に格納する

これらの操作は、この資料の中に載っている関数や構文だけでも実現できますが、要素の挿入や削除といった基本的な操作をする関数は最初から用意されているに決まっています。
そこで、Web 検索などでそのような関数を見つけ、それを用いて上の処理を行ってください。

解答は[こちら](basic1_answer.md)。

## 「何もない」を表す値

皆さんも慣れてきたところで、今まで見て見ぬふりをしてきた `nil` について解説します。

今まで何度か命令の出力に `nil` という文字列が出てきたと思います。
これは「何もない」ということを表す値です。
例えば、配列の何も入っていない部分には `nil` が入っていると見なされます。

```ruby
> a = ["first"]
=> ["first"]
> a[5]  # a は 0 番目の要素しかもたないので 5 番目の要素はない
=> nil
```

`while` でループを書いたときも `nil` が出力されていたはずです。
これは、`while` 文全体がループを実行したあとに `nil` を返すことになっているためです。
このように、Ruby では全ての関数や式は何らかの値を返すようになっていて、特に返すものがない場合などは `nil` を返すようになっているのです。