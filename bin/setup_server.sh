#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

readonly SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
readonly PROJECT_HOME="${SCRIPT_DIR}/.."

sudo apt-get update

# Nginx
sudo apt-get install -y nginx

# Uvicorn + FastAPI
sudo apt-get install -y pip
pip install fastapi uvicorn

# MySQL
sudo apt-get install -y mysql-server

# MySQL client
sudo apt-get install -y libmariadb-dev
pip install mysqlclient
