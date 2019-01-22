# 京プリポスト向けクラウド環境用OACIS環境

## 事前準備
PythonおよびOpenStack clientのインストールが必要です。

OpenStack clientは、以下のようにインストールします。
```
pip install python-openstackclient
```

また、このディレクトリに京コンピュータログイン用のssh鍵ペアを以下のファイル名で
置いておく必要があります。
 - 秘密鍵: id_rsa.K
 - 公開鍵: id_rsa.K.pub

## セットアップ方法
1. 京プリポスト向けクラウド環境用のVPNに接続します。

2. Webブラウザで https://10.9.255.25 にアクセスし、
京プリポスト向けクラウド環境用VPNのユーザ名・パスワードを入力して
Horizon Service(OpenStackのダッシュボード)に接続します。

3. Horizonの[プロジェクト][コンピュート][アクセスとセキュリティー]の
ページの[APIアクセス]タブを開き、[OpenStack RC v2.0ファイルのダウンロード]
ポタンをクリックし、"rccs-atd-openrc_v2.sh"をダウンロードします。

4. "rccs-atd-openrc_v2.sh"を、以下のように実行します。
```
. rccs-atd-openrc_v2.sh
Please enter your OpenStack Password for project rccs-atd as user <ユーザ名>:
```

  ここで、京プリポスト向けクラウド環境用VPNのパスワードを入力します。

5. "os_create_server.sh"を実行します。
京プリポスト向けクラウド環境のOpenStackで、以下のVMがプロビジョニングされます。
 - OS: Ubuntu16.04_LTS
 - Flavor: A2.small
 - name: oacis_<ユーザ名>

6. "os_install_docker.sh"を実行します。
プロビジョニングされたVM上にDocker CEがインストールされます。尚、VMへのsshログインのために
京コンピュータログイン用のssh秘密鍵のパスフレーズが聞かれます。

[WIP]
