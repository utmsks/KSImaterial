# githubへのアクセス
___204号室実習用ネットワーク限定です。___

システムのプロキシ設定が読まれない場合は、gitでproxyの設定をするとよい。
```
$ git config --global http.proxy http://cache.ks.prv:8080
$ git config --global https.proxy http://cache.ks.prv:8080
$ git config --global url."https://".insteadOf git://
```
