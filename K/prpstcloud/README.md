# 京プリポスト向けクラウド環境用OACIS環境

## 事前準備
PythonおよびOpenStack clientのインストールが必要です。

OpenStack clientは、Python付属のpipコマンドで、以下のようにインストールします。
```
pip install python-openstackclient
```

また、京コンピュータログイン用のssh鍵ペアを用意しておく必要があります。
このディレクトリに以下のファイル名で鍵ペアのファイルを置いておくと、インストール途中で
鍵ファイルの場所の入力を求められません。

 - 秘密鍵: id_rsa.K
 - 公開鍵: id_rsa.K.pub

## 利用方法
1. 京プリポスト向けクラウド環境用のVPNに接続します。

2. Webブラウザで https://10.9.255.25 にアクセスし、
京プリポスト向けクラウド環境用VPNのユーザ名・パスワードを入力して
Horizon Service(OpenStackのダッシュボード)に接続します。

3. Horizonの[プロジェクト][コンピュート][アクセスとセキュリティー]の
ページの[APIアクセス]タブを開き、[OpenStack RC v2.0ファイルのダウンロード]
ポタンをクリックし、"<グループ名>-openrc.sh"をダウンロードします(v3.0でも構いません)。

4. "<グループ名>-openrc.sh"を、以下のように実行します。
```
. <グループ名>-openrc.sh
Please enter your OpenStack Password for project <グループ名> as user <ユーザ名>:
```

  ここで、京プリポスト向けクラウド環境用VPNのパスワードを入力します。

5. "./start_oacis_os.sh"を実行します。
京プリポスト向けクラウド環境のOpenStackで、以下のVMがプロビジョニングされます。
 - OS: Ubuntu16.04_LTS
 - Flavor: A2.small
 - name: oacis_<ユーザ名>
 
  その後、プロビジョニングされたVM上にDocker CEがインストールされ、
  ここでoacis_dockerのコンテナ(oacis_K)が実行されます。

  尚、"start_oacis_os.sh"実行の途中、VMへのsshログインのために
  京コンピュータログイン用のssh秘密鍵のパスフレーズが聞かれます。ただし、事前にssh-agentに
  京の秘密鍵(id_rsa.K)を登録している場合は、パスフレーズは聞かれません。

6. WebブラウザでOACISにアクセスします。
以下のURLにアクセスすることで、京プリポスト向けクラウド環境のOpenStack VM上で動作する
Dockerコンテナ(oacis_K)上のOACISのページを参照できます。
```
http://localhost:3000/
```
Hostページを参照すると「K」というホスト名で京のログインノードが登録されています。

## 終了方法
OACISの使用を終了し、京プリポスト向けクラウド環境のOpenStack VMを削除するには、
"rccs-atd-openrc_v2.sh"を実行したターミナルで"stop_oacis_os.sh"を実行します。
```
./stop_oacis_os.sh
```


## License

- [oacis_sim](https://github.com/Fujitsu-Nagano-CES/oacis_sim) is a part of [OACIS](https://github.com/crest-cassia/oacis).
- OACIS and oacis_docker are published under the term of the MIT License (MIT).
- Copyright (c) 2018-2019 Fujitsu and R-CCS, RIKEN
