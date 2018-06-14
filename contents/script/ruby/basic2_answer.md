# Ruby ― 基本編 II 演習問題解答

## 演習問題 1

例えば以下のようなプログラムが考えられます。

```ruby
def prime?(x)
  res = true
  for i in 2..(x - 1)
    if x % i == 0
      res = false
      break
    end
  end
  return res
end
for x in 2..1000
  if prime?(x)
    p x
  end
end
```

## 演習問題 2

例えば以下のようなプログラムが考えられます。
あくまで一例です。

```ruby
def primes(n)
  box = []
  primes = []
  for i in 2..n
    if box[i] == nil
      primes << i
      for j in 2..(n / i)
        box[i * j] = 0
      end
    end
  end
  return primes
end
```

## 演習問題 3

```ruby
class Comp
  attr_accessor "real", "imaginary"
  def initialize(r, i)
    self.real = r
    self.imaginary = i
  end
  def abs
    return Math.sqrt(self.real * self.real + self.imaginary * self.imaginary)
  end
  def plus(other)
    return Comp.new(self.real + other.real, self.imaginary + other.imaginary)
  end
end
```

## 演習問題 4

```ruby
class Comp
  attr_accessor "real", "imaginary"
  def initialize(r, i)
    self.real = r
    self.imaginary = i
  end
  def abs
    return Math.sqrt(self.real * self.real + self.imaginary * self.imaginary)
  end
  def +(other)
    return Comp.new(self.real + other.real, self.imaginary + other.imaginary)
  end
  def *(other)  # 追加
    r = self.real * other.real - self.imaginary * other.imaginary
    i = self.real * other.imaginary + self.imaginary * other.real
    return Comp.new(r, i)
  end
end
```

つまり、実は Ruby において、`+` や `*` のような演算子のように見えたものは単なるメソッドにすぎないのです。
したがって、ユーザーが自由に定義することができます。

## 演習問題 5

```ruby
class Comp
  attr_accessor "real", "imaginary"
  def initialize(r, i)
    self.real = r
    self.imaginary = i
  end
  def abs
    return Math.sqrt(self.real * self.real + self.imaginary * self.imaginary)
  end
  def +(other)
    return Comp.new(self.real + other.real, self.imaginary + other.imaginary)
  end
  def *(other)
    r = self.real * other.real - self.imaginary * other.imaginary
    i = self.real * other.imaginary + self.imaginary * other.real
    return Comp.new(r, i)
  end
  def ==(other)  # 追加
    return self.real == other.real && self.imaginary == other.imaginary
  end
end
```

ちなみに、ここでは練習のために複素数を扱うクラスを自作してもらいましたが、実は Ruby には標準で複素数を扱う機能が備わっています。
しかも、`3 + 4i` のように、プログラム中でそれっぽく書くことができます。
試しに使ってみましょう。

```ruby
a = 3 + 4i
b = 4 - 7i
p a.abs
p b.abs
c = a + b
d = a * b
p c.real
p c.imaginary
p d.real
p d.imaginary
p a * b + c * d == 305 - 160i
```

あなたが自作した `Comp` クラスを用いた計算結果と一致していますか?