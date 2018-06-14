# Ruby ― 基本編 II

## ruby の利用

そろそろプログラムが長くなってきて、1 命令ごとに出力が返ってくる irb では煩わしくなってきていると思います。
そこで、今後はプログラムをまとめて実行する ruby を用いることにしましょう。

まず、以下のソースコードを適当なエディタで入力し、「ruby.rb」などのファイル名で保存してください。

```ruby
students = []
students[0] = ["Tanimura", "geometry"]
students[1] = ["Ohori", "algebra"]
students[2] = ["Takahashi", "analysis"]
students = students.sort
p students[1][1]  # 出力
```

同じフォルダ内で、ターミナルから以下のコマンドを実行してみましょう。

```
$ ruby ruby.rb
```

すると、以下のような出力が得られるはずです。

```
"analysis"
```

このような方法で Ruby コードを実行するときの注意点として、毎回実行結果が表示されるわけではないので、何からのデータをターミナル上に表示したい場合は、`p` などの出力用メソッドを用いて、明示的に出力するよう Ruby に指示する必要があります。

以下で「これを実行すると」などと言った場合は、該当のソースコードを上で説明したように適当なファイルに保存して、ruby コマンドで実行しているものとします。

## メソッド

さて、[基本編 I](basic.md) の演習問題 2 を覚えているでしょうか。
そこでは、以下のようなプログラムを書きました。

```ruby
x = 84697
res = true
for i in 2..(x - 1)  # i に 2 から x - 1 までの数字を代入する
  if x % i == 0      # もし x が i でわり切れたら
    res = false      # res に false を代入して
    break            # 繰り返しを終了する
  end
end
if res
  p "prime"
else
  p "not prime"
end
```

これは 84697 が素数かどうかを判別するプログラムでした。
しかし、これが例えば 57781, 62507, 75327, 84687のうち素数でないものはどれか、という問題であった場合、これを 4 つコピペして並べることになってしまいます。
これを避けるために、新たに関数 (もしくは「メソッド」と呼ぶことも多い) を定義してみましょう。

メソッドを定義するには、まず、`def` に続いてメソッド名を書き、その直後に引数として受け取る変数の名前を括弧の中に入れて書きます。
この行から `end` までがメソッドの中身になります。
メソッドの中身で `return` に続いて式を書くと、その式の結果がメソッドの返り値になります。

```ruby
def prime?(x)  #「prime?」という名前のメソッドを定義
  res = true
  for i in 2..(x - 1)
    if x % i == 0
      res = false
      break
    end
  end
  return res  # res の値を返す
end
p prime?(4)      # prime? の x に 4 を渡して実行しその結果を出力
p prime?(84697)
```

Ruby では何かを判定して真偽値を返すメソッドの名前は末尾に `?` を付ける慣習があるので、ここでは `prime?` という名前にしました。

これを実行すると以下のような出力が得られるはずです。

```
false
true
```

## 演習問題 1

上で定義した `prime?` メソッドを用いて、2 以上 1000 以下の素数を順に出力するプログラムを作成してください。

解答は[こちら](basic2_answer.md)。

## 演習問題 2

上で定義した `prime?` メソッドでは、引数に与えられた数未満の全ての整数で実際にわってみて、どれでもわれなかったら素数と判定するという処理をしています。
これは非効率です。

素数の一覧を作るには、「エラトステネスの篩」と呼ばれるより効率的な方法があります。
エラトステネスの篩を用いて、引数に与えられた数以下の素数全てを配列にして返すメソッドを作成してください。
エラトステネスの篩の詳しいアルゴリズムについては適当に検索してください。

解答は[こちら](basic2_answer.md)。

## オブジェクト

ここまでで手続き型プログラミングについての最低限のことはマスターしたと言ってもおそらく大丈夫でしょう。
ここからは、とうとうオブジェクト指向プログラミングについて解説しようと思います。
今までに比べると抽象度が一段上がって難しいですが、慣れすぎると思考回路がそちらにシフトしてしまって手続き型ってどうやるんだっけと一瞬思ってしまうほどに便利なものです。

オブジェクト指向プログラミングは、「クラス」, 「オブジェクト」, 「メソッド」の 3 つの概念からなります。
まずはクラスとオブジェクトについて説明するために、谷村君を例にとってみましょう。

谷村君は人類です。
この場合、「人類」というのは抽象的な生物の種類名です。
生き物図鑑の項目名と言っても良いでしょう。
集合の名前と言っても良いでしょうか。
人類という分類の中に谷村君という具体的な要素が存在します。
この文脈においては、人類がクラスで、谷村君がそのオブジェクトです。
すなわち、クラスとは抽象的な分類であり、オブジェクトとはそれに分類される具体的なものです。

人類の特徴として「身長」や「体重」などが挙げられます。
人類のこれらの特徴を管理するプログラムを作成してみましょう。

クラスは `class` の後にクラス名を書くことで定義できます。
そのクラスがもつデータは `attr_accessor` の後に文字列を並べることで宣言できます。

```ruby
class Homosapiens                   # クラス名の頭文字は必ず大文字
  attr_accessor "height", "weight"  # Homosapiens のデータは height と weight で構成される
end
```

作ったクラスのオブジェクトを作るには、クラス名の後に `.new` と続けます。
このように作ったオブジェクトの後に `.` を挟んでデータ名を書けば、そのデータの値を参照したり代入したりできます。

```ruby
class Homosapiens                   # クラス名の頭文字は必ず大文字
  attr_accessor "height", "weight"  # Homosapiens のデータは height と weight で構成される
end

tanimura = Homosapiens.new  # オブジェクトの作成
tanimura.height = 175       # 谷村の身長は 175 cm
tanimura.weight = 50        # 谷村の体重は 50 kg

p tanimura.height  # 代入されたかの確認
```

しかし、登録する度にいちいち `hoge.height = piyo` などとやっていてはソースコードは長くなってしまいます。
それを避けるために、クラス内で `initialize` メソッドを定義します。

```ruby
class Homosapiens
  attr_accessor "height", "weight"

  def initialize(h, w)
    self.height = h
    self.weight = w
  end
end
```

こうすると、`new` でオブジェクトを作るときに、引数としてデータを渡すことができます。
例えば、谷村君の身長が 175 cm で体重が 50 kg であるというのは次のように書くことができます。

```ruby
tanimura = Homosapiens.new(175, 50)
p tanimura.height  # 出力して確認
p tanimura.weight
```

最後に、メソッドについて解説しましょう。
こちらは、オブジェクトの関数をクラスの性質として組み込むものです。
例えば、人類の身長が高いかどうかを判定するメソッドを組み込んでみましょう。

```ruby
class Homosapiens
  attr_accessor "height", "weight"

  def initialize(h, w)
    self.height = h
    self.weight = w
  end
  def tall?                   # 身長が高いかを返すメソッドを定義
    return self.height > 170  # メソッド内では「自分自身」は self で参照できる
  end
end
```

これで大丈夫です。確かめてみましょう。

```ruby
tanimura = Homosapiens.new(175, 50)
p tanimura.tall?
someone = Homosapiens.new(158, 85)
p someone.tall?
```

メソッドには引数を渡すこともできます。

```ruby
class Homosapiens
  attr_accessor "height", "weight"

  def initialize(h, w)
    self.height = h
    self.weight = w
  end
  def taller_than?(h)   # 1 引数のメソッド taller_than? を定義
    return self.height > h
  end
end
```

使ってみましょう。

```ruby
tanimura = Homosapiens.new(175, 50)
p tanimura.taller_than?(165)
someone = Homosapiens.new(158, 85)
p someone.taller_than?(170)
```

## 演習問題 3

複素数を管理するクラス `Comp` を作成してください。
この `Comp` クラスは、実部 `real` と虚部 `imaginary` をデータとしてもちます。
`initialize` メソッドを定義して、オブジェクト作成時に実部と虚部を渡せるようにすると良いでしょう。

さらに、ここで作った `Comp` クラスに、自身の絶対値を返す `abs` メソッドと、他の複素数を引数にとって自身との和を返す `plus` メソッドを追加してください。

例えば、以下のようなプログラムを実行したとしましょう。

```ruby
a = Comp.new(3, 4)
b = Comp.new(4, -7)
p a.abs
p b.abs
c = a.plus(b)
p c.real
p c.imaginary
```

この出力は以下のようになることを期待します。

```
5.0
8.06225774829855
7
-3
```

解答は[こちら](basic2_answer.md)。

## 演習問題 4

上の演習問題で作成した `Comp` クラスの `plus` メソッドの名前を、`plus` から `+` に変更してみましょう。
すると、演算子風に `a + b` のような形式でこのメソッドが呼べるようになることを確認してください。

このことを利用して、複素数の積を `a * b` のように計算できるようにしてください。

解答は[こちら](basic2_answer.md)。

## 「等しい」ということ (ポインタについて)

最後に、少し難しい話をします。
配列を操作していると、次のような一見不可解な現象が起こります。

```ruby
a = [1, 2, 3]  # a に配列 [1, 2, 3] を代入する
b = a          # b にも a と同じものを代入する
b[1] = 4       # b の 1 番目を 4 にする
p b[1]
p a[1]
```

これを実行すると以下のようになると思います。

```
4
4
```

つまり、`b` の 1 番目だけを `4` にしたつもりが、`a` の 1 番目も変わってしまっているのです。

なぜこのような現象が起こるのでしょうか?
それは、`b = a` という文は `b` に `a` の中身である配列 `[1, 2, 3]` を代入しているというより、`a` そのもの (`a` のメモリ番号) を代入しているためです。

オブジェクトでも同じことが起こりますが、そちらの方がより分かりやすいと思います。
先程の `Homosapiens` クラスを例にとって考えてみましょう。

```ruby
class Homosapiens
  attr_accessor "height", "weight"
  def initialize(h, w)
    self.height = h
    self.weight = w
  end
end

tanimura = Homosapiens.new(175, 50)
ohori = Homosapiens.new(175, 50)
```

この場合、谷村 (`tanimura`) と大堀 (`ohori`) は同じ「身長が 175 cm で体重が 50 kg である」人類ですが、全く別の人類です。
この 2 人がどうやって区別されているかというと、それぞれが別のメモリ番号に登録されているのです。

メモリ番号は `object_id` というメソッド で確認できます。

```ruby
class Homosapiens
  attr_accessor "height", "weight"
  def initialize(h, w)
    self.height = h
    self.weight = w
  end
end

tanimura = Homosapiens.new(175, 50)
ohori = Homosapiens.new(175, 50)
p tanimura.object_id
p ohori.object_id
```

実行してみましょう。

```
50547000
50546940
```

メモリ番号は実行するたびに変わるので、上の通りの出力ではないかと思いますが、少なくとも異なる番号が 2 つ出力されるはずです。
これによって `tanimura` と `ohori` の両者は区別されています。

先程の配列の例に戻りましょう。
`a` と `b` のメモリ番号を確認してみます。

```ruby
a = [1, 2, 3]
b = a
p a.object_id
p b.object_id
```

実行すると以下のようになります。

```
50441860
50441860
```

前と同じく実際の数値は上の例と異なると思いますが、同じ数値が 2 つ出力されるはずです。
つまり、`a` と `b` は同じメモリ番号上のものを参照しているわけです。
したがって、`a` の中身を変えれば、同じものを参照している `b` の中身も変わるわけです。

これにより、`b` の 1 番目だけ変えたければ中身が同じ別の (メモリ番号上の) 配列を作成しなくてはなりません。
そのために、Ruby の配列クラスには `clone` というメソッドが用意されています。
このメソッドは中身が同じものを別のメモリ番号にもう 1 つ確保して、それを返します。

```ruby
a = [1, 2, 3]
b = a.clone    # a と中身が同じ別の配列を作成して b に代入
p a.object_id
p b.object_id

b[1] = 4
p a
p b
```

実行結果は以下のようになるはずです。

```
50458220
50458180
[1, 2, 3]
[1, 4, 3]
```

`a` と `b` のメモリ番号が違うため、しっかり `b` だけの中身が変更されています。

以上のように、オブジェクト指向の世界では、「中身のデータの値が同じ (同値性)」と「メモリ上の位置が同じ (同一性)」という 2 種類の「等しい」という関係があります。
これをうやむやにすると、思わぬ罠に嵌まる可能性があるので注意しましょう。

ところで、Ruby には `==` という「等しさ」を判定する演算子がありますが、これは配列などの場合では「中身のデータの値が同じかどうか」を判定しますが、上の `Homosapiens` のように独自に定義したクラスでは「メモリ上の位置が同じ」かを判定します。
以下のコードで確認してみましょう。

```
class Homosapiens
  attr_accessor "height", "weight"
  def initialize(h, w)
    self.height = h
    self.weight = w
  end
end

tanimura = Homosapiens.new(175, 50)
ohori = Homosapiens.new(175, 50)
p tanimura == ohori

a = [1, 2, 3]
b = [1, 2, 3]
p a == b
```

しかし、独自のクラスでも配列と同じように中身のデータが同じかどうかを判定してほしい場合があります。
これは、クラス内で `==` を再定義することで実現できます。

```ruby
class Homosapiens
  attr_accessor "height", "weight"
  def initialize(h, w)
    self.height = h
    self.weight = w
  end

  def ==(other)  # == の再定義
    return self.height == other.height && self.weight == other.weight
  end
end


tanimura = Homosapiens.new(175, 50)
ohori = Homosapiens.new(175, 50)
p tanimura == ohori
```

## 演習問題 5

前の演習問題で作成した `Comp` クラスの `==` をうまく再定義して、複素数の同値性を判定できるようにしてください。

解答は[こちら](basic2_answer.md)。