# Scheme入門

SchemeというのはLISP言語の方言である。LISPが最初は人工知能（AI）の研究為の開発された非常に古い言語である。今使われているLISP重要な方言が２つでり：Scheme(強調がミニマリズム：必要な機能だけ)とCommon Lisp(強調が機能：機能が非常に多いので、ちょっと複雑)。

## インストール

最初は、guileをインストールしよう（Ubuntu /Debian対応）。

```
$ sudo apt-get install guile-2.0
```

## 基本な計算

guileを使い始める為、ターミナルでguileをタイプして、Enterを押す:

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

Scheme(又は、LISP)が初心者にとって難しいということが良く言われている。例えば、数式に[ポーランド記法](https://ja.wikipedia.org/wiki/%E3%83%9D%E3%83%BC%E3%83%A9%E3%83%B3%E3%83%89%E8%A8%98%E6%B3%95)を使う：

```
scheme@(guile-user)> (+ 2 2)
$1 = 4
scheme@(guile-user)> (+ 2 (+ 1 1))
$2 = 4
scheme@(guile-user)> (+ 3 (+ 1 2))
$3 = 6
scheme@(guile-user)> (sqrt 16)　 ;因みに、Schemeのコメントがセミコロンから始まる
$4 = 4
```

変数を定義する為、(define <name> <val>)とういう関数を使う：

```
scheme@(guile-user)> (define my-name "snoopy")
scheme@(guile-user)> my-name
$1 = "snoopy"
```

今のセッションを終わる為、(exit)問いう関数を使う：

```
scheme@(guile-user)> (exit)
$ 
```

## データ型

Schemeの重要な基本なデータ型は以下のようである：

* **数字**（整数、実数、複数、有理数）
* **文字列**（ストリング）
* **ブーリアン**

更に、複合データ型が一個だけで、**ペア**(英：pair)と呼ばれているものである。しかし、ペアを使って色々な他の複合データ型を定義できる。例えば、**リスト**（配列）である。

## 数字

数字は色々な形で書ける：

```
scheme@(guile-user)> #b111 ;バイナリー
$1 = 7
scheme@(guile-user)> #o111 ;八進法
$2 = 73
scheme@(guile-user)> #x111 ;十六進法
$3 = 273
scheme@(guile-user)> 6.02e+1;指数表記
$4 = 60.2
scheme@(guile-user)> 1+2i ;複数
$5 = 1.0+2.0i
scheme@(guile-user)> 1/3 ;有理数
$6 = 1/3
```

Schemeの特徴は正確性である。即ち、Schemeはなるべく不正確な実数の代わりに、正確な有理数と整数を使う：

```
scheme@(guile-user)> (define a 42) ;正確で、整数
scheme@(guile-user)> (- a 5) ;まだ正確で、まだ整数
$1 = 37
scheme@(guile-user)> (/ a 47); 正確で、有理数になる
$2 = 42/47
scheme@(guile-user)> (sqrt a); 不正確になった
$3 = 6.48074069840786
scheme@(guile-user)> (exact->inexact (/ (+ 39 48 72 23 91) 5)); 正確から不正確なタイプへ直接に変化することもできる
$4 = 54.6
```

もちろん、数字に関わる関数は色々である。例えば、

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

もっと詳しい情報はguileの[マニュアル（英語）](https://www.gnu.org/software/guile/manual/html_node/Numbers.html#Numbers)に書いている

## ブーリアン

#tがTRUEで、#fがFALSEを表す：

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
scheme@(guile-user)> (string-length s1) ;ストリングの長さ調べる関数
$2 = 5
scheme@(guile-user)> (substring s2 0 3);部分列を取る関数
$3 = " wo"
```

もっと詳しい情報はguileの[マニュアル（英語）](https://www.gnu.org/software/guile/manual/html_node/Strings.html#Strings)に書いている

## ペア

ペアのアイディアを分かる為、例を見ると市場有用である：

```
scheme@(guile-user)> (define p (cons 1 2)) ;ペアを作る
scheme@(guile-user)> (car p) ;ペアの最初のメンバーを取る
$1 = 1
scheme@(guile-user)> (cdr p) ;ペアの最後のメンバーを取る
$2 = 2
```

ペアのメンバーは基本的なデータ型の元だけではなく、他のペアでもOKなので、consを再帰的に使うと、非常に複雑なものが作れる。

## 配列

定義によって、配列が再帰的に使われたconsの結果である：

```
scheme@(guile-user)> '()  ;空配列
$1 = ()
scheme@(guile-user)> (cons 1 '())　;一個元の配列
$2 = (1)
scheme@(guile-user)> (cons 1 (cons 2 '()))　;2個元の配列
$3 = (1 2)
scheme@(guile-user)> (cons 1 (cons 2(cons 3 '()))) ;3個元の配列
$4 = (1 2 3)
```

配列(リスト)は特別なペアであり、独立なデータ型のものではない。しかし、便利の為Schemeに配列のいくつ速記がある：

```
scheme@(guile-user)> (list 1 2 3) ;これは(cons 1 (cons 2(cons 3 '())))と一緒
$1 = (1 2 3)
scheme@(guile-user)> '( 1 2 3)　;これも(cons 1 (cons 2(cons 3 '())))と一緒
$2 = (1 2 3)
```

LISPの元々の意味は"LISt Processor"（リスト処理機構）であるから、リストはLISP言語で非常に大事に見られるということが分かる。LISP言語で、リストは複合データ型を作るの唯一の方法になる。さて、リストに関する関数も多い：

### null?

```
scheme@(guile-user)> (null? '(a b c)) ;'(a b c)は空配列ではないので、#fになる
$1 = #f
scheme@(guile-user)> (null? '()) ;'()は空配列であるので、#tになる
$2 = #t
```

### length

```
scheme@(guile-user)>(length '()); lengthとは、リストの長さがを計算する関数である
$1 = 0
scheme@(guile-user)>(length '(a b c))
$2 = 3
```

### list-ref

```
scheme@(guile-user)>(list-ref '(a b c) 1); (list-ref l k)はリストlから第k個目の元をとる；0から数える
$1 = b
scheme@(guile-user)>(list-ref '(a b c) 3); エラーが起こることも可能
ERROR: In procedure list-ref:
ERROR: In procedure list-ref: Argument 2 out of range: 3

Entering a new prompt.  Type `,bt' for a backtrace or `,q' to continue.
```

### list-tail

```
scheme@(guile-user)>(list-tail '(a b c) 1); (list-tail l k)はリストlの第k個目の元から全ての元をとる；0から数える
$1 = (b c)
scheme@(guile-user)>(list-tail '(a b c) 3)
$2 = ()
scheme@(guile-user)>(list-tail '(a b c) 4); エラーが起こることも可能
ERROR: In procedure list-tail:
ERROR: In procedure list-tail: Wrong type argument in position 1 (expecting pair): ()

Entering a new prompt.  Type `,bt' for a backtrace or `,q' to continue.
```

### list-head

```
scheme@(guile-user)>(list-head '(a b c) 1); (list-head l k)はリストlの最初のk個元をとる
$1 = (a)
scheme@(guile-user)>(list-head '(a b c) 4); エラーが起こることも可能
ERROR: In procedure list-head:
ERROR: In procedure list-head: Wrong type argument in position 1 (expecting pair): ()

Entering a new prompt.  Type `,bt' for a backtrace or `,q' to continue.
```

### append

```
scheme@(guile-user)>(append '(a b c) '(d e f) '(g)) ;与えられたリストを加える
$1 = (a b c d e f g)
```

### reverse

```
scheme@(guile-user)>(reverse '(a b c)) ;リストの順番を逆にする
$1 = (c b a)
```

### filter

以下に説明されたfilterとmapという関数でlambdaという文法を使い、その文法は次の節（「関数の定義方」）で説明された。簡単にいうと、(lambda(x)(...))はxをパラメータとして持つ関数を定める。LISPで関数を他の関数のパラメータとして使える。

(filter pred list)とは、リストlistから条件predを満たす元をとる関数である。条件predは関数に現れるものである。即ち、(pred x)は#tにならば、xは条件を満たすとする。逆に、（pred x）は#fにならば、満たさないとする。例、

```
scheme@(guile-user)> (define lessthanthree (lambda(x)(< x 3)))
scheme@(guile-user)> (lessthanthree 3)
$1 = #f
scheme@(guile-user)> (lessthanthree 2.9)
$2 = #t
scheme@(guile-user)> (filter lessthanthree '(1.9 2.4 3.2 4.3 1.2)); 3.0未満実数だけをとる
$3 = (1.9 2.4 1.2)
```

### map

(map f L1 L2 ... Ln)とは、関数fと長さ同じいリストL1, L2 ,..., Ln をとる関数である（nは１でも良い。つまり、(map f l)でも良い）。この関数の効果を理解するため、第i個目のリストLiの元がAi1, Ai2, ..., Aimになるとする。そうすると、(map f L1 L2 ... Ln)の結果は長さmのリストLになる。そこでLの第i個目の元Biが以下のようになる：

Bi = (f A1i A2i ... Ani)

例、

```
scheme@(guile-user)> (define addThreeNumbers (lambda(x y z)(+ x y z)))
scheme@(guile-user)> (map addThreeNumbers '(1 2 3) '(4 5 6) '(7 8 9))
$1 = (12 15 18)
```

## 関数の定義方

### defineとlambda

Schemeで関数を定義するため、前に述べたdefine文法と今から説明するlambda文法を使う。簡単にいうと、(lambda(x)(...))はxをパラメータとして持つ関数を定める。例、

```
scheme@(guile-user)> (define addone (lambda(x)(+ x 1)))
scheme@(guile-user)> (addone 4)
$1 = 5
```

或いは `(define addone (lambda(x)(+ x 1)))` の代わりに、もっと簡単な `(define (addone x) (+ x 1))` という文法も使える（効果が全く同じい）。

LISPで関数を他の関数のパラメータとして使える。例、

```
scheme@(guile-user)> (define (addone x)(+ x 1))
scheme@(guile-user)> (define (applytwice func arg) (func(func arg))); 関数funcをパラメーターargに対して、２回適応する
scheme@(guile-user)> (applytwice addone 4)
$1 = 6
```

### 再帰
Schemeで非常に大事のは、**再帰**（英、recursion）という概念である。再帰によって、もっと複雑な関数を綺麗で、簡単に定義することができる。例、

```
scheme@(guile-user)> (define (factorial n) (if (zero? n) 1 (* n (fact (- n 1)))))
scheme@(guile-user)> (factorial 5)
$1 = 120
```

ifという文法が以下に説明された。簡単にいうと(if cond a1 a2)と書けば、もしcondが成り立てば（つまり、もし、condが#tにならば）、a1が結果になる。もし、condは#fにならば、a2が結果になる。

## 制御フロー

### if

まず、前に述べたifから始めよう。簡単にいうと(if cond a1 a2)と書けば、もしcondが成り立てば（つまり、もし、condが#tにならば）、a1が結果になる。もし、condは#fにならば、a2が結果になる。例、

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

condというのは、ifの一般化として見られる。文法は以下のようになる

```
(cond
    (test1 expr1)
    (test2 expr2)
    ...
    (testN exprN)
    (else exprLast))
```

test1, test2, ..., testN の公式が一個一個で計算される。もし、第i個目の公式testIが#tにならば、次のtest(I+1), ..., testNを計算せず、結果がexprIになる。もし、test1, test2, ..., testNが全てが#fにならば、exprLastが結果になる。例、

```
scheme@(guile-user)> (define a 3)(define b 5)
scheme@(guile-user)> (cond ((< a b) "a is less than b")
... ((= a b) "a equals b")
... (else "a is greater than b"))
$1 = "a is less than b"
```

### let、let*とletrec

プログラミングするとき、新しい変数 を定義する必要がよくある。この前は、変数の定義ため、define文法のみを使った。しかし、defineで変数定義をすれば、その変数は全体のプログラムで見える。それは他のプログラム言語の**グローバル変数**（global variables）概念みたい。しかし、今作っている関数でしか見られな**ローカル変数**変数を定める必要がよくある。そのとき、以下に説明されたlet、let*とletrecを使う。

### let

ローカル変数を定めるため一番基本的な文法である。文法が以下のようになる

```
(let ((var1 val1)
      (var2 val2)
      ...
      (varN valN))
      expr)
```

まず、val1, val2, ..., valNが全部計算され、その結果はvar1, ..., varNに割り当てする。その後は、exprが計算され、その結果は全体のlet公式の結果になる。exprでvar1, var2, ..., varNを使える。例、
```
scheme@(guile-user)> (let(
... (a 1)
... (b 2)
... (c 3))
... (+ a b c)) ; a + b + c = 1 + 2 + 3 = 6
$1 = 6
scheme@(guile-user)> a ;letで定義された変数を外から見られない
;;; <unknown-location>: warning: possibly unbound variable `a'
```

### let*

let*の文法はletと全く同じであるが、

```
(let* ((var1 val1)
      (var2 val2)
      ...
      (varN valN))
      expr)
```

意味がちょっと違う：

* val1, val2, ..., valNが順々に計算され、第i個目のvalIで前に定義されたvar1, var2, ..., var(I-1)を使える；
* しかし、varIでまだ定義されていないvar(I+1),...,varNが使えない；

例、

```
scheme@(guile-user)> (let(
... (a 1)
... (b 2)
... (c (+ a b))) ;c = a + b = 1 + 2 = 3
... (* c c))    ;c * c = 3 * 3 = 9
$1 = 9
```

### letrec

letrecの文法もletと全く同じであるが、

```
(letrec ((var1 val1)
      (var2 val2)
      ...
      (varN valN))
      expr)
```

意味がちょっと違う：

* 任意のvalIでvar1, var2, ..., varNを全部使える；
* ...まだ未定義ものを使える!
* ...再帰も使える！
* (...色々な間違えが起こる可能性が存在する)

例、

```
scheme@(guile-user)> (define even?
... (letrec
... ((even? (lambda(x)( odd? (- x 1) )))
... (odd? (if (= x 0) #f ( even? (- x 1))))
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
