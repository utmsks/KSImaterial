# sshによるサーバ利用

実習用PCから各自に割り当てられた実習用サーバにログインする手順を示します。

最初は初期パスワードでログインしますが、公開鍵暗号を用いた認証方式に変更します。
パスワードでログインできると、漏洩した場合や総当たり攻撃を受けた場合に危険性があるためです。
（実習用ネットワークには外部からは入れないので実質的な危険性は小さいですが、練習のためこの設定をします。）

## 準備
「計算数学　サーバ実習」と書かれたプリント1枚を各自受け取り、記載されている
* 共通情報　サーバ名
* 固有情報　ログイン名・初期パスワード・外部SSHポート番号

を確認しておく。

## ウィンドウ
sshを起動し、サーバにコマンドを入力するウィンドウを開く。以後の作業はすべてこの中で行う。
* Windowsの場合は、コマンドプロンプトまたはPowershell
* MicrosoftストアアプリのUbuntuの場合は、シェルのウィンドウ
* ネイティブまたは仮想マシン上のLinuxの場合は、端末またはターミナル

## 手順
1. パスワードを使ってログインする。
```
$ ssh ksuserNN@exp.ks.prv -p 外部SSHポート番号
Password: <<与えられた初期パスワードを入力>>
```
1. ログインしたら、すぐパスワードを変更する。
```
$ passwd
Changing password for ksuserNN
Current password: <<初期パスワードを入力>>
New password: <<新しいパスワード>>
Retype new password: <<もういちど>>
```
1. いったんログアウトする。
```
$ logout
```
1. 実習用PC上で公開鍵暗号の設定をする。
Linux, Windows共通です。
```
$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the hey (...): <<リターン>>
Enter passphrase (empty for no passphrase): <<適当な長さのパスフレーズ>>
```
1. 確認
```
$ ls ~/.ssh
id_rsa  id_rsa.pub
```
`id_rsa`には秘密鍵が入っています。
__他のPC等にコピーしたり、他人に見せたりしてはいけません。__
`id_rsa.pub`には公開鍵が入っています。
1. 公開鍵をサーバにコピーする。
```
$ scp ~/.ssh/id_rsa.pub ksuserNN@exp.ks.prv -p 外部SSHポート番号
```
リターンを押す前に、コピー元が公開鍵（`id_rsa.pub`）になっていることを指さし確認する！
1. もう一度サーバにログインする。
```
$ ssh ksuserNN@exp.ks.prv -p 外部SSHポート番号
Password: <<さっき変更した新しいパスワード>>
```
1. 公開鍵がコピーされていることを確認し、この鍵を使えるようにする。
```
$ ls
id_rsa.pub
$ mkdir .ssh
$ cat id_rsa.pub >> .ssh/authorized_keys
$ rm id_rsa.pub
```
1. 一度logout.
1. もう一度サーバにログインする。今度はパスワードは聞かれないかわりに、公開鍵を作った時のパスフレーズが聞かれるはず。
```
$ ssh ksuserNN@exp.ks.prv -p 外部SSHポート番号
Enter passphrase for key '...': <<パスフレーズ>>
```
もしパスワードを聞くプロンプトが出たら、authorized_keysの設定が間違っている（ファイル名違いが多い）ので（パスワードを入力してログインして）確認する。
1. 公開鍵認証でのログインができたら、パスワードでのログインを不可にする。
```
$ sudo vi /etc/ssh/sshd_config
```
上のようにエディタ（viでなくてもいい）で設定ファイルを開き、
```
#PasswordAuthentication yes
```
の行を
```
PasswordAuthentication no
```
に変更する。行頭の`#`も消していることに注意。
忘れずにセーブしてエディタを終了する。
1. ログアウトして、再度ログインしてみる。
公開鍵のパスフレーズをわざとまちがえて、パスワードを聞いてこないことを確かめるとよい。
