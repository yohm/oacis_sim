# OACIS demo environment with simulators / PC

1台のPC上で、OACISとシミュレータを動作させるデモ環境です。

OACISも各シミュレータも、それぞれPC上のDockerコンテナ上で稼働します。

## 事前準備

実行するPCには、Dockerがインストールされている必要があります。
Docker Toolbox(Windows 8.1以前、またはWindows 10 Home環境)用の設定は含まれません。

## 利用方法

このディレクトリ(PC/)配下の`util/start_oacis_dockers.sh`を実行すると、
必要なDockerイメージが作成され、コンテナが起動します。

```
$ util/start_oacis_dockers.sh -h
start_oacis_dockers.sh: start oacis docker container (from oacis_sim/oacis_pc)
usage: start_oacis_dockers.sh [-f] [-g] [-m]
  -f  start ffb docker container (from oacis_sim/ffb) simultaneously
  -g  start genesis docker container (from oacis_sim/genesis) simultaneously
  -m  start mdacp docker container (from oacis_sim/mdacp) simultaneously
```

オプションなしでこのコマンドを実行すると、OACISのDockerコンテナが起動します。
その後、Webブラウザで`localhost:3000/`にアクセスするとOACISのポータル画面が表示されます。

現時点では、ffb(-fオプション)とgenesis(-mオプション)は、実行環境がインストールされた
Dockerコンテナの起動までしか行いません。

mdacp(-mオプション)は、実行環境がインストールされたDockerコンテナを起動し、
OACISのDockerコンテナにHost, Simulatorの登録まで行います。
この場合は、以下のようにstart_oacis_dockers.shを実行します。
```
start_oacis_dockers.sh -m
```

尚、起動したコンテナの停止、イメージの削除を行うためのユーティリティが
`util/stop_oacis_dockers.sh`にあります。

```
$ util/stop_oacis_dockers.sh -h
stop_oacis_dockers.sh: stop all docker containers (from oacis_sim/* image)
usage: stop_oacis_dockers.sh [-d [-i]]
  -d  delete oacis_sim/* docker image(s) simultaneously
  -i  request confirmation before delete each docker image
```

オプションなしでこのコマンドを実行すると、起動したDockerコンテナ
(ベースのDockerイメージが"oacis_sim/*"のもの)を全て停止します。

"-d"オプションをつけると、ベースとなったDockerイメージの削除も行います。
この時"-i"オプションを付けると、各イメージごとに削除するかどうかを尋ねます。

## License

- [oacis_sim](https://github.com/Fujitsu-Nagano-CES/oacis_sim) is a part of [OACIS](https://github.com/crest-cassia/oacis).
- OACIS and oacis_docker are published under the term of the MIT License (MIT).
- Copyright (c) 2018-2019 Fujitsu and R-CCS, RIKEN

