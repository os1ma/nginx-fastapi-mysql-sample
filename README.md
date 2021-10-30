# nginx-fastapi-mysql-sample

Nginx + FastAPI + MySQL による掲示板のサンプルコード

ライブラリは mysqlclient と axios のみ使用

## 開発環境起動手順

```console
docker-compose up
```

## サーバ上での実行手順

サーバにファイル転送

```console
rsync -ahvz \
  -e "ssh -i <key-file>" \
  --exclude .git \
  . \
  <user>@<host>:<dir>/nginx-fastapi-mysql-sample
```

サーバ内をセットアップ

```console
ssh -i <key-file> <user>@<host> <dir>/nginx-fastapi-mysql-sample/bin/setup_server.sh
```
