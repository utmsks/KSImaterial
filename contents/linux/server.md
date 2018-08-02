# Dockerを使ったサーバ環境準備

20班ないし受講生40名のためのLinux実習、サーバ実習のための環境を用意する。

同一の環境を多数簡便に用意する必要があること、
実習で各ユーザが発生する負荷は大きくない
（Linuxのコマンド学習、簡単なサーバの立ち上げなど）
ことを考え、
Dockerを採用する。

### Docker imageの設定
* 班ないしユーザごとにDocker containerを用意
* 一般ユーザ権限でssh login可能とする。
* login名、パスワードをimageに含める。
* IPアドレスはサーバインターフェイスのものを利用。
* sshのTCPポート番号をcontainer毎にマップして割り当てる。
* ssh以外に、サーバ実習用に一つのポートを同様にマップして割り当てておく。

### ポート番号のマップ規則
班／ユーザ番号を nm (n, mは0~9のいずれか)とするとき
* 22 (ssh) -> 2nm22
* 4011 (サーバ用) -> 2nm11

## サーバハードウェア・ソフトウェア

### ハードウェア
* PowerEdge R440 サーバ
* インテル® Xeon® ブロンズ 3104 1.7G x2
* 16GB RDIMM, 2667MT/s x4
* 1.2TB 10K RPM SAS 12Gbps 512n 2.5インチ
* On-Board Broadcom 5720 デュアル ポート 1Gb

### OS
* Ubuntu Server 18.04

### ミドルウェア
* Docker 17.12.1-ce (apt install docker-ce)
* Docker Compose 1.22.0-rc2

## Docker imageの準備
Dockerfile
```
FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN useradd -m -s /bin/bash ksuser
RUN echo 'ksuser:screencast' | chpasswd
#RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
```

Docker image生成
```
$ docker build -t user_sshd .
```

Docker image確認
```
$ docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
user_sshd           latest              49350a9e261d        40 minutes ago      209MB
```

Docker Compose設定ファイル
`docker-compose.yml`
```
version: '3'

services:
  user_sshd_00:
    image: user_sshd
    ports:
      - "20022:22"
      - "20011:4011"      

  user_sshd_01:
    image: user_sshd
    ports:
      - "20122:22"

  user_sshd_02:
    image: user_sshd
    ports:
      - "20222:22"
```

Docker container生成
```
$ docker-compose up -d
Starting docker_user_sshd_00_1 ... done
Starting docker_user_sshd_01_1 ... done
Starting docker_user_sshd_02_1 ... done
$ docker container ls -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                      PORTS                                            NAMES
474a563d33fd        user_sshd           "/usr/sbin/sshd -D"      44 minutes ago      Up 25 seconds               0.0.0.0:20022->22/tcp, 0.0.0.0:20011->4011/tcp   docker_user_sshd_00_1
8e8a42195654        user_sshd           "/usr/sbin/sshd -D"      44 minutes ago      Up 24 seconds               0.0.0.0:20122->22/tcp                            docker_user_sshd_01_1
90b9f9f1d3a6        user_sshd           "/usr/sbin/sshd -D"      44 minutes ago      Up 26 seconds               0.0.0.0:20222->22/tcp                            docker_user_sshd_02_1
f64a37ce2e00
```

動作確認
```
GFrege[~ 0 1011] ssh 192.168.1.130 -p 20222 -l ksuser
ksuser@192.168.1.130's password:
Welcome to Ubuntu 16.04.4 LTS (GNU/Linux 4.15.0-23-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
Last login: Thu Jul 12 04:43:12 2018 from 192.168.1.154
ksuser@90b9f9f1d3a6:~$ ps -ea
  PID TTY          TIME CMD
    1 ?        00:00:00 sshd
    8 ?        00:00:00 sshd
   17 ?        00:00:00 sshd
   18 pts/0    00:00:00 bash
   24 pts/0    00:00:00 ps
ksuser@90b9f9f1d3a6:~$ logout
```

停止
```
$ docker-compose stop
Stopping docker_user_sshd_00_1 ... done
Stopping docker_user_sshd_01_1 ... done
Stopping docker_user_sshd_02_1 ... done
```
