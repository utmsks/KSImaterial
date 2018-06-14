# Ruby 発展編

## 拡張ライブラリの作成

この節では C 言語の最低限の知識を前提としているので、C 言語が分からない方は飛ばしていただいても構いません。

今まで見てきていただければ分かる通り、Ruby は大変手軽な文法と強力なライブラリを兼ね備えた言語です。
しかし、Ruby はスクリプト言語なのでヘビーな計算には耐えられません。
そこで、計算部分を C 言語で書かれた拡張ライブラリに押し付けて大枠を Ruby で仕上げるという策を取ります。
本節では、C 言語の基本的な部分を知っている方を対象に、Ruby 拡張ライブラリの作成方法を紹介します。

例として、ある整数が素数かどうか判定するメソッド `prime?` の定義されたモジュール `Prime` を作成してみます。
まずは、C 言語のソースコードを「prime.c」という名前を作成します。
Ruby 拡張ライブラリ作成のためには、ヘッダファイルとして ruby.h を読み込む必要があります。

```c
#include <ruby.h> 
```

次に、もととなる関数を用意しましょう。

```c
int prime(int n) {
  int i;
  if (n <= 1) {
    return 1;
  }
  for (i = 2 ; i < n / 2 + 1 ; i ++) {
    if (n % i == 0) {
      return 1;
    }
  }
  return 0;
}
```

これは、引数が素数なら `0` を、素数でなければ `1` を返す関数です。
これをもとに Ruby の関数を作成しましょう。

```c
VALUE prime2(VALUE self, VALUE n) {
  VALUE boo;
  int m = NUM2INT(n);  /* Ruby の整数値を C 言語の int に変換する */
  m = prime(m);        /* 素数かどうかの判定 */
  if (m == 0) {
    boo = INT2NUM(0);  /* C 言語の整数 0 を Ruby の 整数 0 に直す */
  } else {
    boo = INT2NUM(1);
  }
  return rb_equal(boo, INT2NUM(0));  /* boo == 0 */
}
```

ここで見慣れない変数型 `VALUE` が登場しています。
これは Ruby の値一般を表す構造体で、Ruby の値は整数, 浮動小数点, 文字列, その他いかなるオブジェクトも全て `VALUE` としてひとまとめにされます。
最後に、モジュール `Prime` を作成して `prime2` を `prime?` として登録しましょう。

```c
void Init_Prime(void) {                                       /* 関数名は Init_(モジュール名) */
  VALUE rb_mPrime;                                            /* この変数名は特にこだわる必要はない */
  rb_mPrime = rb_define_module("Prime");                      /* モジュール Prime を生成して rb_mPrime に代入 */
  rb_define_module_function(rb_mPrime, "prime?", prime2, 1);  /* メソッドを登録 */
}
```

これでライブラリのソースコードが完成しました。
次にコンパイル作業に入ります。
これは C 言語で書かれたソースなのですが、gcc で普通にコンパイルしても動きません。
Ruby には「mkmf」という拡張パッケージを作るためのパッケージが存在するのでこれを用います。
まず、「extconf.rb」というファイルを作成して、次の 2 行を打ち込みます。

```ruby
require "mkmf"
create_makefile("Prime")
```

そして、端末で次の命令を実行します。

```
$ ruby extconf.rb
$ make
```

これで拡張ライブラリ Prime.so が作成されました。
エラーが出る場合には[こちら](trouble.md)をご覧ください。
早速、irb でテストしてみましょう。

```ruby
> require "./Prime.so"
=> true
> Prime.prime?(5)
=> true
> Prime.prime?(4)
=> false
```

拡張ライブラリ作成のための C 言語の命令はリファレンスマニュアルの C API の項にまとめられています。