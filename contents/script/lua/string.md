# Lua 入門：文字列

## 文字列

### 文字↔文字コード

`string.char()` 関数は，引数を文字コードにもつ文字（引数が複数個与えられた場合は全部つなげた文字列）を返します．
逆に，`string.byte()` で，引数の文字列 `s` の文字コードを返します．文字列 `s` の長さを取得するには `string.len(s)` を使います．

```lua
print(string.char(66))           --> B
print(string.char(95,82,116,43)) --> _Rt+

print(string.byte('W'))          --> 87
print(string.byte('AX'))         --> 65
print(string.byte('AX',2))       --> 88 （2 文字目 'X' の文字コード）

print(string.len('hogera'))      --> 6
print(string.len('あ'))          --> 3 （UTF-8 では仮名は 1 文字 3 バイト）
```

最初にも書いたように，Lua では文字列は多バイト文字には対応しておらず，文字列は単なるバイト列としての扱いです．そのため，日本語などを「正しく」扱うことはそのままではできません．
例えば，`string.len('あ')` が 1 ではなく 3 となります．これは，Debian 7 ではデフォルトの文字コードが UTF-8（[Wikipedia 中の解説記事](http://ja.wikipedia.org/wiki/UTF-8)）であるからで，UTF-8 では「あ」は 0xE3 0x81 0x82 という 3 バイトによって表現されているからです．

###  部分文字列と書式指定表示

部分文字列は `string.sub()` で得られます．

```lua
s = 'Quod Erat Demonstrandum'
print(string.sub(s,1,6))   --> Quod E
print(string.sub(s,6,9))   --> Erat
print(string.sub(s,-6))    --> randum         （最後の 6 バイト）
print(string.sub(s,11))    --> Demonstrandum  （11 バイト目以降）
print(string.sub(s,1,-10)) --> Quod Erat Demo （後ろの 10 バイト以外）
```

C言語の `printf` のように，書式を指定して何かを出力したい場合は，一旦 `string.format()` を利用して文字列を作り，それを `print()` することになります．

```lua
p, n = math.pi*100, 1701
print(string.format('%e', p)) --> 3.141593e+02
print(string.format('%f', p)) --> 314.159265
print(string.format('%o', n)) --> 3245
print(string.format('%X', n)) --> 6A5
print(string.format('n = %d, p = %g', n, p)) --> n = 1701, p = 314.159
```

数値を 8 進法や 16 進法で表示するときに，このように `string.format()` を使うことができます．逆に，文字列 `s` を n 進法の数値だと思って数値に変換したい場合は，`tonumber(s, n)` と第 2 引数を指定します：

```lua
print(tonumber('1701')) --> 1701
print(tonumber('1701',8)) --> 961
print(tonumber('1701',16)) --> 5889
```

**課題** 「掛け算九九」ならぬ 16進法の「掛け算 FF」の表を作れ．

なお，文字列には，メタテーブルとして `{__index = string}` が自動的に割り当てられます．わかりやすい言葉で言うなら，`string.sub(s,2)` などの代わりに，`s:sub(2)` と書いても同じであるということです．

```lua
s = 'Quod Erat Demonstrandum'
print(s:sub(6,9))        --> Erat
print(string.sub(s,6,9)) --> ERat
print('Quod Erat Demonstrandum':sub(6,9)) -- 文法上のエラー
print(('Quod Erat Demonstrandum'):sub(6,9)) --> Erat
```

### 文字列の検索

文字列からある特定の**パターン**を検索するには，`string.find()` や `string.match()` を使います．前者はマッチの先頭位置と最後の位置を返します．一方，`string.match()` はマッチ自体（か，キャプチャがあればキャプチャ）を返します．

**パターン**とは，Lua における正規表現のようなものです．以下にいくつかの例を示します：

```lua
print(string.match('qwertyuiop', 'w..'))    --> wer
  -- . は任意の 1 文字にマッチ
print(string.match('17KR', '%dK'))          --> 7K
  -- %d は数字 1 文字にマッチ
print(string.match('17KR', '%u'))           --> K
  -- %u は英大文字にマッチ
print(string.match('eiqwertyuiop', 'e.*i')) --> eiqwertyui
  -- r* は r の 0 回以上の繰り返し
print(string.match('qwertyuiop', 'p..'))    --> nil（見つからなかったので）
```

注意するところとして，大きく次の 2 点があります：

* 「文字の特別な意味をなくす」には `\` の代わりに `%` を用いる
* 「2つの正規表現のいずれかにマッチ」する `|` は実装されていない

詳細は [Lua 5.2 Reference Manual の "6.4.1 Patterns"](http://www.lua.org/manual/5.2/manual.html#6.4.1) （[日本語訳](http://milkpot.sakura.ne.jp/lua/lua52_manual_ja.html#6.4.1)）を参照してください．

**キャプチャ**とは，パターン内の `( )` で囲まれた部分です．パターン内にキャプチャがあると，`string.match()` は各キャプチャを返します．

```lua
a, b, c = string.match(
  'Supercalifragilisticexpialidocious',
  '(c.*(f..).*l).*(e.*a)'
)

print(a) --> califragil
print(b) --> fra
print(c) --> expia
```

```lua
function dec(s)
  return string.match(s, "<(%x+)>%s+(%d+)")
    -- %x は 16 進数字に，%s は空白文字にマッチ
end

print(dec('<2361> 816')) --> 2361  816
print(dec('<2361>   a')) --> nil
print(dec('<a> 816'))    --> a     816
print(dec('<627>  42s')) --> 627   42
```
