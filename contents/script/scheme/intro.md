# Scheme入門

SchemeというのはLISP言語の方言である。LISPは、当初は人工知能（AI）の研究のために開発された非常に古い言語である。今使われているLISPの重要な方言は2つある：Scheme (ミニマリズムを強調：必要な機能だけ)とCommon Lisp (機能を強調：機能が非常に多いので、ちょっと複雑)。

## インストール

最初は、guileをインストールしよう（Ubuntu/Debian対応）。

```
$ sudo apt-get install guile-2.0
```

## 基本な計算

guileを使うには、ターミナルでguileをタイプして、Enterを押す:

```
$ guile
GNU Guile 2.0.11
Copyright (C) 1995-2014 Free Software Foundation, Inc.

Guile comes with ABSOLUTELY NO WARRANTY; for details type `,show w'.
This program is free software, and you are welcome to redistribute it
under certain conditions; type `,show c' for details.

Enter `,help' for help.
scheme@(guile-user)> 
```

Scheme (または、LISP)が初心者にとって難しいということが良く言われている。例えば、数式に[ポーランド記法](https://ja.wikipedia.org/wiki/%E3%83%9D%E3%83%BC%E3%83%A9%E3%83%B3%E3%83%89%E8%A8%98%E6%B3%95)を使う：

```
scheme@(guile-user)> (+ 2 2)
$1 = 4
scheme@(guile-user)> (+ 2 (+ 1 1))
$2 = 4
scheme@(guile-user)> (+ 3 (+ 1 2))
$3 = 6
scheme@(guile-user)> (sqrt 16)　 ;因みに、Schemeのコメントはセミコロンから始まる
$4 = 4
```

変数を定義するには、 `(define <name> <val>)` という関数を使う：

```
scheme@(guile-user)> (define my-name "snoopy")
scheme@(guile-user)> my-name
$1 = "snoopy"
```

今のセッションを終えるには、 `(exit)` という関数を使う：

```
scheme@(guile-user)> (exit)
$ 
```

## データ型

Schemeの重要な基本データ型は以下である：

* **数字**（整数、実数、複素数、有理数）
* **文字列**
* **ブーリアン**（真理値）

更に、複合データ型として、**ペア**(英：pair)と呼ばれているものがある。ペアを使って、色々な他の複合データ型を定義できる。例えば、**リスト**はペアを使って定義される。

## 数値

数は色々な形で書ける：

```
scheme@(guile-user)> #b111 ;二進法 (binary)
$1 = 7
scheme@(guile-user)> #o111 ;八進法
$2 = 73
scheme@(guile-user)> #x111 ;十六進法
$3 = 273
scheme@(guile-user)> 6.02e+1;指数表記
$4 = 60.2
scheme@(guile-user)> 1+2i ;複素数
$5 = 1.0+2.0i
scheme@(guile-user)> 1/3 ;有理数
$6 = 1/3
```

Schemeの数の特徴は正確性 (exactness) である。即ち、Schemeは不正確 (inexact) な実数および、正確 (exact) な有理数と整数を扱える：

```
scheme@(guile-user)> (define a 42) ;正確な整数
scheme@(guile-user)> (- a 5) ;まだ正確な数のまま（整数）
$1 = 37
scheme@(guile-user)> (/ a 47); 正確な有理数になる
$2 = 42/47
scheme@(guile-user)> (sqrt a); 不正確になった
$3 = 6.48074069840786
scheme@(guile-user)> (exact->inexact (/ (+ 39 48 72 23 91) 5)); 正確な数から不正確な数へ直接変換することもできる
$4 = 54.6
```

もちろん、数に関わる関数は色々である。例えば、

```
scheme@(guile-user)> (expt 2 3) ;冪演算
$1 = 8
scheme@(guile-user)> (expt 2 3)
$2 = 1.0986122886681098
scheme@(guile-user)> (quotient 5 2) ;商
$3 = 2
scheme@(guile-user)> (remainder 5 2) ;剰余
$4 = 1
scheme@(guile-user)> (max 423 536 4564)
$5 = 4564
scheme@(guile-user)> (min 423 536 4564)
$6 = 423
scheme@(guile-user)> (<= 3 4) ; #t := TRUE
$7 = #t
scheme@(guile-user)> (atan 1)
$8 = 0.7853981633974483
```

もっと詳しい情報はguileの[マニュアル（英語）](https://www.gnu.org/software/guile/manual/html_node/Numbers.html#Numbers)に書かれている。

## ブーリアン

`#t` が真 (true) を、 `#f` が偽 (false) を表す：

```
scheme@(guile-user)> (not #t)
$1 = #f
scheme@(guile-user)> (and #t #f #t)
$2 = #f
scheme@(guile-user)> (or #t #f #f)
$3 = #t
```

## 文字列

文字列の扱い方は他の言語とほぼ一緒である:

```
scheme@(guile-user)> (define s1 "hello")
scheme@(guile-user)> (define s2 " world!")
scheme@(guile-user)> (string-append s1 s2)
$1 = "hello world!"
scheme@(guile-user)> (string-length s1) ;文字列の長さを調べる関数
$2 = 5
scheme@(guile-user)> (substring s2 0 3);部分列を取る関数
$3 = " wo"
```

もっと詳しい情報はguileの[マニュアル（英語）](https://www.gnu.org/software/guile/manual/html_node/Strings.html#Strings)に書かれている。

## ペア

まずはペアの例を見てみよう：

```
scheme@(guile-user)> (define p (cons 1 2)) ;ペアを作る
scheme@(guile-user)> (car p) ;ペアの最初のメンバーを取る
$1 = 1
scheme@(guile-user)> (cdr p) ;ペアの最後のメンバーを取る
$2 = 2
```

ペアのメンバーは基本的なデータ型の元だけではなく、他のペアでもOKなので、consを再帰的に使うと、非常に複雑なものが作れる。

## リスト

consを再帰的に使うことによって、リストを作ることができる：

```
scheme@(guile-user)> '()  ;空リスト
$1 = ()
scheme@(guile-user)> (cons 1 '())　;1個の要素からなるリスト
$2 = (1)
scheme@(guile-user)> (cons 1 (cons 2 '()))　;2個の要素からなるリスト
$3 = (1 2)
scheme@(guile-user)> (cons 1 (cons 2 (cons 3 '()))) ;3個の要素からなるリスト
$4 = (1 2 3)
```

リストは特別なペアであり、独立なデータ型のものではない。しかし、便利の為Schemeにはリストの省略記法がある：

```
scheme@(guile-user)> (list 1 2 3) ;これは(cons 1 (cons 2 (cons 3 '())))と一緒
$1 = (1 2 3)
scheme@(guile-user)> '( 1 2 3)　;これも(cons 1 (cons 2 (cons 3 '())))と一緒
$2 = (1 2 3)
```

LISPの元々の意味は"LISt Processor"（リスト処理機構）であるから、リストはLISP言語で非常に大事に見られるということが分かる。LISP言語で、リストは複合データ型を作るの唯一の方法になる。さて、リストに関する関数も多い：

### null?

```
scheme@(guile-user)> (null? '(a b c)) ;'(a b c)は空リストではないので、#fになる
$1 = #f
scheme@(guile-user)> (null? '()) ;'()は空リストであるので、#tになる
$2 = #t
```

### length

```
scheme@(guile-user)>(length '()); lengthは、リストの長さを計算する関数である
$1 = 0
scheme@(guile-user)>(length '(a b c))
$2 = 3
```

### list-ref

```
scheme@(guile-user)>(list-ref '(a b c) 1); (list-ref l k)はリストlから第k個目の要素をとる；0から数える
$1 = b
scheme@(guile-user)>(list-ref '(a b c) 3); 範囲外の場合はエラーが起こる
ERROR: In procedure list-ref:
ERROR: In procedure list-ref: Argument 2 out of range: 3

Entering a new prompt.  Type `,bt' for a backtrace or `,q' to continue.
```

### list-tail

```
scheme@(guile-user)>(list-tail '(a b c) 1); (list-tail l k)はリストlの第k個目以降の全ての要素をとる；0から数える
$1 = (b c)
scheme@(guile-user)>(list-tail '(a b c) 3)
$2 = ()
scheme@(guile-user)>(list-tail '(a b c) 4); 範囲外の場合はエラーが起こる
ERROR: In procedure list-tail:
ERROR: In procedure list-tail: Wrong type argument in position 1 (expecting pair): ()

Entering a new prompt.  Type `,bt' for a backtrace or `,q' to continue.
```

### list-head

```
scheme@(guile-user)>(list-head '(a b c) 1); (list-head l k)はリストlの最初のk個の要素をとる
$1 = (a)
scheme@(guile-user)>(list-head '(a b c) 4); 範囲外の場合はエラーが起こる
ERROR: In procedure list-head:
ERROR: In procedure list-head: Wrong type argument in position 1 (expecting pair): ()

Entering a new prompt.  Type `,bt' for a backtrace or `,q' to continue.
```

### append

```
scheme@(guile-user)>(append '(a b c) '(d e f) '(g)) ;与えられたリストを連結する
$1 = (a b c d e f g)
```

### reverse

```
scheme@(guile-user)>(reverse '(a b c)) ;リストの順番を逆にする
$1 = (c b a)
```

### filter

以下の `filter` と `map` という関数の説明で lambda という文法を使うが、詳しくは次の節（「関数の定義」）を参照。簡単にいうと、 `(lambda (x) (...))` は `x` をパラメータとして持つ関数を定める。LISPでは関数を他の関数のパラメータとして使える。

`(filter pred list)` とは、リスト `list` から条件 `pred` を満たす要素をとる関数である。条件 `pred` は関数である。即ち、`(pred x)` が `#t` ならば、 `x` は条件を満たすとする。逆に、 `(pred x)` が `#f` ならば、満たさないとする。例：

```
scheme@(guile-user)> (define lessthanthree (lambda (x) (< x 3)))
scheme@(guile-user)> (lessthanthree 3)
$1 = #f
scheme@(guile-user)> (lessthanthree 2.9)
$2 = #t
scheme@(guile-user)> (filter lessthanthree '(1.9 2.4 3.2 4.3 1.2)); 3.0未満の実数だけをとる
$3 = (1.9 2.4 1.2)
```

### map

`(map f L1 L2 ... Ln)` とは、関数 `f` と、長さの同じリスト `L1, L2 ,..., Ln` をとる関数である（n は 1 でも良い。つまり、 `(map f l)` でも良い）。

仮に、第 i 個目のリスト `Li` の要素が `Ai1, Ai2, ..., Aim` であるとする。そうすると、 `(map f L1 L2 ... Ln)` の結果は長さ m のリスト `L` であり、その `L` の第 i 個目の元 `Bi` は以下のようになる：

`Bi = (f A1i A2i ... Ani)`

例：

```
scheme@(guile-user)> (define addThreeNumbers (lambda(x y z)(+ x y z)))
scheme@(guile-user)> (map addThreeNumbers '(1 2 3) '(4 5 6) '(7 8 9))
$1 = (12 15 18)
```

## 関数の定義

### defineとlambda

Schemeで関数を定義するため、先に述べたdefineと新たに説明するlambdaを使う。簡単にいうと、 `(lambda (x) (...))` は `x` をパラメータとして持つ関数を定める。例、

```
scheme@(guile-user)> (define addone (lambda (x) (+ x 1)))
scheme@(guile-user)> (addone 4)
$1 = 5
```

あるいは `(define addone (lambda(x)(+ x 1)))` の代わりに、もっと簡単な `(define (addone x) (+ x 1))` という文法も使える（意味は全く同じ）。

LISPでは関数を他の関数のパラメータとして使える。例、

```
scheme@(guile-user)> (define (addone x)(+ x 1))
scheme@(guile-user)> (define (applytwice func arg) (func(func arg))); 関数funcをパラメーターargに対して、2回適用する
scheme@(guile-user)> (applytwice addone 4)
$1 = 6
```

### 再帰

Schemeで非常に大事のは、**再帰**（英：recursion）という概念である。再帰によって、複雑な関数を綺麗で、簡単に定義することができる。例：

```
scheme@(guile-user)> (define (factorial n) (if (zero? n) 1 (* n (fact (- n 1)))))
scheme@(guile-user)> (factorial 5)
$1 = 120
```

`if` という文法は以下で説明する。

## 制御フロー

### if

まず、先に述べた `if` から始めよう。簡単にいうと `(if cond a1 a2)` と書いた場合、もし `cond` が成り立てば（もし `cond` が `#t` ならば）、 `a1` が結果になる。もし、 `cond` が `#f` にならば、 `a2` が結果になる。例：

```
scheme@(guile-user)> (if #t "true" "false")
$1 = "true"
scheme@(guile-user)> (if #f "true" "false")
$2 = "false"
scheme@(guile-user)> (if (< 2 3) "true" "false")
$3 = "true"
scheme@(guile-user)> (if (> 2 3) "true" "false")
$4 = "false"
```

### cond

`cond` というのは、 `if` の一般化として見られる。文法は以下のようになる

```
(cond
    (test1 expr1)
    (test2 expr2)
    ...
    (testN exprN)
    (else exprLast))
```

式 `test1`, `test2`, ..., `testN` が順番に計算される。もし、第 i 個目の式 `testI` が `#t` になれば、次の `test(I+1)`, ..., `testN` は計算されず、 `exprI` が結果となる。もし、 `test1`, `test2`, ..., `testN` が全てが `#f` にならば、 `exprLast` が結果となる。例：

```
scheme@(guile-user)> (define a 3)(define b 5)
scheme@(guile-user)> (cond ((< a b) "a is less than b")
... ((= a b) "a equals b")
... (else "a is greater than b"))
$1 = "a is less than b"
```

### let、let*とletrec

プログラミングするとき、新しい変数を定義したいことがよくある。ここまでは、変数の定義にはdefine文のみを使った。defineで定義した変数はそれ以後の式や文からも見える。一方、式の一部からしか参照できない変数を定義する場合は、以下に説明された `let`、`let*` と `letrec` を使う。

### let

ローカル変数を定義する一番基本的な文法である。文法は以下のようになる：

```
(let ((var1 val1)
      (var2 val2)
      ...
      (varN valN))
      expr)
```

まず、 `val1`, `val2`, ..., `valN` が全部計算され、その結果が `var1`, ..., `varN` に割り当てられる。その後は、 `expr` が計算され、その結果は全体の `let` 式の結果になる。`expr` からは `var1`, `var2`, ..., `varN` を参照できる。例：

```
scheme@(guile-user)> (let(
... (a 1)
... (b 2)
... (c 3))
... (+ a b c)) ; a + b + c = 1 + 2 + 3 = 6
$1 = 6
scheme@(guile-user)> a ;letで定義された変数は外から見得ない
;;; <unknown-location>: warning: possibly unbound variable `a'
```

### let*

`let*` の文法は `let` と全く同じであるが、

```
(let* ((var1 val1)
      (var2 val2)
      ...
      (varN valN))
      expr)
```

意味がちょっと違う：

* `val1`, `val2`, ..., `valN` が順々に計算され、第 i 個目の `valI` からはすでに定義された `var1`, `var2`, ..., `var(I-1)` を使える。
* しかし、 `valI` ではまだ定義されていない `varI`, `var(I+1)`, ..., `varN` は使えない。

例：

```
scheme@(guile-user)> (let(
... (a 1)
... (b 2)
... (c (+ a b))) ;c = a + b = 1 + 2 = 3
... (* c c))    ;c * c = 3 * 3 = 9
$1 = 9
```

### letrec

`letrec` の文法も `let` と全く同じであるが、

```
(letrec ((var1 val1)
      (var2 val2)
      ...
      (varN valN))
      expr)
```

意味がちょっと違う：

* 任意の `valI` から `var1`, `var2`, ..., `varN` の全てを使える。
* ...まだ未定義なものを使える!
* ...再帰も使える！
* (...色々なバグが起こる可能性がある)

例、

```
scheme@(guile-user)> (define even?
... (letrec
... ((even? (lambda(x)( odd? (- x 1) )))
... (odd? (if (= x 0) #f (even? (- x 1))))
... even?))
scheme@(guile-user)> (even? 8)
$1 = #t
scheme@(guile-user)> (even? 7)
$1 = #f
```

## 参考文献

1. Daniel P. Friedman "[The Little Schemer](https://mitpress.mit.edu/books/little-schemer)"（和訳は[図書館](https://opac.dl.itc.u-tokyo.ac.jp/opac/opac_details/?reqCode=fromlist&lang=0&amode=11&bibid=2003291782&opkey=B147494697910727&start=1&totalnum=2&listnum=1&place=&list_disp=20&list_sort=6&cmode=0&chk_st=0&check=00)である） -- 色々なScheme問題の収集です。数学者（特に、論理、個人言語理論又は組み合わせ論に興味がある方）にとって面白いと思う
2. Abelson, Sussman, and Sussman "Structure and Interpretation of Computer Programs" https://mitpress.mit.edu/sicp/
3. もうひとつの Scheme 入門　http://www.shido.info/lisp/idx_scm.html
