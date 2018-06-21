# Lua 入門：テーブル

## テーブル

**記法** 以下，下の行のように，`-->` の後ろに表示結果を記述することにします（`--` で始まっているので，ここはコメントとなります）：

```lua
print(1+2) --> 3
```

テーブルは，複数のものをまとめて扱うための仕組みで，**Lua における唯一のデータ構造**です．何はともあれ，まず例を見ていきましょう：

```lua
a = {} -- empty table
a[1] = 'foo'
a['hoge'] = 42
print(a[1])   --> foo
print(a.hoge) --> 42
  -- a.hoge == a['hoge']
print(a[0])   --> nil

b = a
b[1] = 'bar'
print(b.hoge) --> 42
print(b[1])   --> bar
print(a[1])   --> bar
```

* 新しいテーブルは，`{ ... }` のように brace で囲んで記述します．1 行目の `{}` は空のテーブルです．

* テーブル内の要素は `[ ... ]` を使ってアクセスします．`a[1]` は，`a` で表されるテーブルの，キーとして数値の 1 を持つような要素を表します．キーとしては，nil, NaN を除く任意の値が使えます．
  7 行目のコメントに書いてあるように，`a.hoge` という表現は `a['hoge']` と全くの等価です．

* キーに対応する値が代入されていない場合は `nil` を返します（8 行目）．

* 1 行目の `a = {}` では，変数 `a` は実際には新たに作られたテーブルへの参照を格納します（`print(a)` してみると，`table: 0x2305060` のようにアドレスが表示されます）．
  9 行目の `b = a` は，参照をコピーしているだけなので，変数 `a` と変数 `b` は同じテーブルを指し示すことになります．
  10 行目の `b[1] = 'bar'` によって，`a[1]` の値が `'foo'` から `'bar'` に変わってしまっているのもこのためです．

**問** 上の状況で変数 `hoge` の値が 1 だったとする．`a[hoge]` はいくつか？

`{ ... }` の中にキーと値の組を `[key]=value` の形式でコンマ区切りで書くことも可能です．

* `['hoge']=val` は `hoge=val` と書いても同じです．
* `[key]=` の部分を省略すると，順番に 1 から連番が割り当てられます．

```lua
t = { hoge=1, 9, 3, [0] = 'p', ['bar']=7, 5 }
print (t.hoge) --> 1. t['hoge'] と同じ
print (t.bar)  --> 7
print (t[1])   --> 9
print (t[2])   --> 3
print (t[3])   --> 5
print (t[0])   --> p
```

### `#` 演算子

テーブル `a` を「配列として扱う」場合，単に `a[2]` のように，キーとして 1 から始まる連続した自然数を使うことにすれば良いです．先に述べたように `a[0]` や `a[-1]` と書いても文法上問題はないですが，Lua では**慣習的に配列は 1 から**始めます．
「配列 `a` のサイズ」を得るには，`#a` を使います．これは， `a[k] ~= nil, a[k+1] == nil` となるような 1 以上の自然数 `k`（のどれか）を返します．

```lua
local a = {}
for i = 1,10 do
  a[i] = i
end
print(#a) --> 10
a[0] = 2000
a.key = 3000
print(#a) --> 10
```

問 テーブル `a` が「配列として扱われていた」とする．`a[#a] = nil, a[#a+1] = v` はそれぞれ何を行うことに相当するか？

### pairs, ipairs

テーブルの中身を巡回したい，という場合は，`pairs()` を使うことができます．

```lua
math.randomseed(os.time()) -- 乱数の初期化

local a = {}
for i = 1,6 do
  a[math.random(10000)] = i -- キーは 1 以上 10000 以下の一様乱数
end

for i,v in pairs(a) do -- 一般 for 文（説明略）
  -- a の各キー・値のペア (i, v) に対して，以下を実行する
  print(i,v)
end
```

を実行すると，例えば

```
1355   2
5015   1
1416   5
7548   6
874    3
6325   4
```

のようになります．この例からもわかるように，`pairs()` で各要素が参照される**順番は一般には不定**です．

配列としてテーブル `a` を扱っている場合，その要素を `a[1]`, `a[2]`, ... と順番に走査していくには，代わりに `ipairs()` を使います．

```lua
local a = {}
for i = -1,5 do
  a[i] = i*i
end
a[7] = 49
for i,v in ipairs(a) do
  print('', i,v)
end
```

を実行すると，

```
 1 1
 2 4
 3 9
 4 16
 5 25
```

のようになります．`a[0]`, `a[-1]`, `a[7]` は `ipairs(a)` によっては参照されません．

### 配列のソート

配列をソートするには，`table.sort()` を使います．標準では，値が昇順になるようにソートされます．

```lua
t, s = { 5, 7, 2, 6, 3, 4, 9 }, ''
table.sort(t)
for _,v in ipairs(t) do
  s = s .. v .. ', '
end
print(s) -- 2, 3, 4, 5, 6, 7, 9,
```

第 2 引数に関数を指定すると，それによって要素間に順序が定まっていると認識してソートされます．例えば，次の例では `t` は降順にソートされます．

```lua
t, s = { 5, 7, 2, 6, 3, 4, 9 }, ''
table.sort(t, 
  function (a,b) return a>b end 
)
for _,v in ipairs(t) do
  s = s .. v .. ', '
end
print(s) -- 9, 7, 6, 5, 4, 3, 2,
```

第 2 引数をうまく指定すれば，通常では比較できないものを「並べ替える」ことも可能です．

```lua
table.sort({ {5, 4}, {2, 8}, {7, 1}, {9, 3} }) -- attempt to compare two table values というエラー

t, s = { {5, 4}, {2, 8}, {5, 1}, {5, 7}, {7, 1}, {9, 3} }, ''
table.sort(t, function(a,b)
  return a[1]<b[1]
end)
for _,v in ipairs(t) do
  s = s .. '{' .. v[1] .. ', ' .. v[2] .. '}, '
end
print(s) -- {2, 8}, {5, 4}, {5, 7}, {5, 1}, {7, 1}, {9, 3},
```

### 応用例：スタック

応用として，スタックを実装してみましょう．スタックは，データが順番に積み重なったもので，

* 「現在一番上にあるデータを取り出し，スタックから消去する」(pop)
* 「一番上にデータを積む」 (push)

という 2 つの操作が基本的です．ここでは，「現在一番上のデータを読むが，スタックからは消さない」(peek) も実装することにします．

```lua
function new_stack()
  local s = {}
    -- stack の中身を格納するテーブル（配列扱い）
    -- local 宣言しているので，直接外からこのテーブルにアクセスすることはできない
  return {
    pop = function ()
      local r = s[#s] -- stack の最後のデータ
      s[#s] = nil     -- stack の最後のデータを消す
      return r
    end,
    push = function (d)
      s[#s+1] = d     -- stack の末尾に追加
    end,
    peek = function ()
      return s[#s]    -- stack の最後のデータ
    end,
  }
end
```

以上で，スタックを作ることができます．使うには `s = new_stack()` とした上で，`s.push( ... )` などとします．以下に実行例を載せました：

```lua
s1 = new_stack()
s2 = new_stack()

s1.push('1')
s2.push('2')
s2.push('4')
s1.push('3')
print(s1.pop())    --> 3
s1.push(s2.pop())
print(s1.peek())   --> 4
print(s1.pop())    --> 4
print(s1.pop())    --> 1
print(s2.pop())    --> 2
print(s1.pop())    --> nil
```

**問** 各 push, pop, peek の操作で，スタック s1, s2 がどのようになったか追跡せよ．

### `:` 記法

上記の実装では，pop, push, peek は各スタックごとに別々の関数となっていました．簡単のために peek は省くとしても，全てのスタックで，関数 pop, push を共有することはできないでしょうか？

全てのスタックで関数 pop, push を共有するためには，pop 等の関数を呼ぶときに，どのスタックから呼ばれたかの情報を渡さないといけません．普通なら，そのような場合には `pop(s1)` のように引数にスタックを書きますが，
より見やすくするために，Lua では `t.hoge(t,n)` のことを `t:hoge(n)` と書いてもよいことになっています．上のコードを : 記法を使って書きなおすと，次のようになります．

```lua
do
  local method = {
    pop = function (x)
      local r = x.s[#(x.s)]
      x.s[#x.s] = nil
      return r
    end,
    push = function (x,d)
      x.s[#(x.s)+1] = d 
    end,
  }
  function new_stack()
    return { s = {}, -- stack の中身
      pop = method.pop, push = method.push }
  end
end

s1 = new_stack()
s2 = new_stack()
s1:push('1')
s2:push('2')
s2:push('4')
s1:push('3')
print(s1:pop())  --> 3
s1:push(s2:pop())
print(s1:pop())  --> 4
print(s1:pop())  --> 1
print(s2:pop())  --> 2
print(s1:pop())  --> nil
```

これで，pop, push の各操作は（外から見えない）method というテーブル内で定義され，全スタック内でそれらが共有されるようになりました．
全てのスタックで関数 pop, push を共有するためには，スタックの内部にあるデータを外から見える形にしないといけないことに注意してください．
しかし，これでもまだ各スタックの定義時に，pop フィールドに `method.pop`（の指し示す関数）を明示的に代入する必要があります．まだ操作が 2 つなので楽ですが，なんとかサボれないでしょうか？

### メタテーブル

メタテーブルという機構を使うと，前節最後の疑問を解決することができます．細かい話は [Programming in Lua (first edition)](http://www.lua.org/pil/contents.html) の第 13, 16 章をみてもらうことにして，ここではさっきのスタックの例を書き換えたものを見てみましょう：

```lua
Stack = {}

function Stack:pop()
  -- function Stack.pop(self) と同義
  local r = self[#self]
  self[#self] = nil
  return r
end
function Stack:push(d)
  -- function Stack.push(self,d) と同義
  self[#self+1] = d
end
function Stack:new()
  -- function Stack.new(self) と同義
  local t = {}
  setmetatable(t,self)
  self.__index = self
  return t
end

s1 = Stack:new()
s2 = Stack:new()
s1:push('1')
s2:push('2')
... 後略 ...
```

下から 4 行目の `s1 = Stack:new()` がどんな操作をするか見てみましょう．先に書いたとおり，これは `s1 = Stack.new(Stack)` と同じことです．

* 新たな空テーブル `t` が作られます．
* `t` にメタテーブルとして `Stack` が割り当てられます．
* 「メタメソッド」 `Stack.__index` に `Stack` 自身が代入されます．
* `t` が値として返されます（これが `s1` になる）．

これだけではよくわからないので，次に `s1:push('1')`，同値な `s1.push(s1,'1')` の動作を見ていきましょう：

* まず，`s1` 内に `'push'` というキーに対応する値がないか探します．`s1 = { }` なので，そんなものはありません．
* 普通ならここでおしまいですが，`s1` にはメタテーブルとして `Stack` が割り当てられていることに注意します．
* このとき，`Stack.__index` (= `Stack`) 内に `'push'` というキーに対応する値がないか探します．今度はきちんと見つかったので，その関数に引数 `s1, '1'` を渡して呼び出します．
* 今の時点で `s1` 自身は空だったので，↑の関数実行後では `s1[1] = '1'` となる．

ここまでくると，オブジェクト指向で言う「クラス」に見た目が似たものになっています．興味のある人は [lua-user wiki: Object Orientation Tutorial](http://lua-users.org/wiki/ObjectOrientationTutorial) も参照してください．

### その他

以前使った 組み込み関数 `math.cos()` も，内部では「`math` という名前のグローバル変数に格納されている，キー `'cos'` に対応する値」として認識されます．`io.read()` など，他の組み込み関数も同様です．そのため，「組み込み関数を上書きする」というややこしいことができてしまいます．

**問** 最後の行の `math.sin_d(30)` が正しく 0.5 を返すのはなぜか？

```lua
print(math.cos)
print(math['cos']) -- math.cos と同じ関数を参照

do
  local pi, sin = math.pi, math.sin
  math.sin_d = function (a)
    return sin(a*pi/180)
  end
end

print(math.sin(math.pi/6)) --> 0.5
print(math.sin_d(30))      --> 0.5

math.pi = 3
  -- 円周率が変わったが，組み込み定数を上書きすることで
  -- その変更に容易に追従することができます（笑）
print(math.sin(math.pi/6)) --> 0.4794255386042

math.sin = math.cos
print(math.sin(0))         --> 1
print(math.sin_d(30))      --> 0.5
```

### 変わった例

キーには `nil`, `NaN` 以外はなんでも使えるので，キーにテーブル自身を使うこともできます．当然，そのキーに対応する値もテーブル自身にすることができます．例えば，

```lua
local a = {}
a[a] = a
print(a)
print(a[a])
print(a[a][a])
print(a.a)
```

を実行すると，

```
table: 0x1f96060
table: 0x1f96060
table: 0x1f96060
nil
```

のようになります（`a.a` は `a['a']` の意味で，`a[a]` とは違うことに注意）．

### 実習課題1

実は，任意のグローバル変数 `hoge` は `_G` という（これまたグローバル変数の）テーブルにある `_G.hoge` (= `_G['hoge']`) のことである．これを踏まえて，次のプログラムを実行すると何が起こるか．

```lua
do
  local g = _G
  function die()
    for i,v in pairs(g) do
      g[i] = nil
   end
  end
end

die()
print()
```

### 実習課題2

Lua のリファレンスマニュアル等を参照して，次のプログラムの最初の 4 行が「定義されていないグローバル変数にアクセスするとエラーを返す」処理であることを納得してください：

```lua
setmetatable(_G, {
  __index = function (t, i)
       error('"' .. tostring(i) .. '" is undefined', 2)
    end
  })

a=2
print(a)
print(b) -- エラー
```

### 実習課題3

負の整数や 0 に対応する値も持つテーブル t が与えられているとする（例えば，`t[i] = i^2 + 1`, ∀i ∈ [-5,5] ∩ Z）．このとき，既に紹介したように，

* `for i,v in ipairs(t) do ... end` では　`t[0]`, `t[-1]`, ... が参照されず，
* `for i,v in pairs(t) do ... end` では　各要素が参照される順番は一般には不定である．

では，`t` の**全ての**要素を，**キーが小さい順**に（つまり，`t[-5]`, `t[-4]`, ... , `t[4]`, `t[5]` のように）参照するためにはどうすればよいか．

### コマンドラインの引数

コマンドラインでスクリプト名と共に指定された引数は，テーブル `arg` に入れられます．スクリプト名のすぐ後ろにある引数から，`arg[1]`, `arg[2]`, ... に格納されていきます．

```lua
print(a)

for i,v in pairs(arg) do
   print('arg[' .. i .. '] = "' .. v .. '"')
end
```

を実行すると，次のようになります．

```
nil
arg[1] = "hoge"
arg[2] = "fuga"
arg[3] = "piyo"
arg[-1] = "lua"
arg[0] = "b.lua"
```

また，Perl のようにコマンドラインからプログラムを与えることもでき，その場合は -e オプションを使用します．すぐ上で使ったプログラムを `b.lua` としますと，

```lua
$ lua -e 'a=1' b.lua  hoge fuga piyo | sort
1                ← -e 'a=1' が先に実行され，b.lua 実行時点では a の値は 1 になった
arg[-1] = "a=1"
arg[-2] = "-e"
arg[-3] = "lua"
arg[0] = "b.lua"
arg[1] = "hoge"
arg[2] = "fuga"
arg[3] = "piyo"
```

のようになります．
