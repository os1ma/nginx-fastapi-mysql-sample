#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

readonly SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
readonly PROJECT_HOME="${SCRIPT_DIR}/.."

set +o xtrace
echo -n "Do you want to run setup_server.sh on host $(hostname)? [y/n]: "
read RUN_PERMISSION

if [[ "${RUN_PERMISSION}" != 'y' ]]; then
  echo "Running script canceled. Input was ${RUN_PERMISSION}."
  exit 1
fi
set -o xtrace

sudo apt-get update

# MySQL
sudo apt-get install -y mysql-server

# MySQL client
sudo apt-get install -y libmariadb-dev
pip install mysqlclient

# Uvicorn + FastAPI
sudo apt-get install -y pip
pip install fastapi uvicorn

# nginx
sudo apt-get install -y nginx
sudo rm -f /etc/nginx/conf.d/*
sudo rm -f /etc/nginx/sites-enabled/*
sudo cp "${PROJECT_HOME}/nginx/conf.d/server.conf" /etc/nginx/conf.d/
sudo sed -i 's/api/localhost/g' /etc/nginx/conf.d/server.conf
sudo rsync -ahv "${PROJECT_HOME}/nginx/html/" /usr/share/nginx/html
sudo systemctl reload nginx
