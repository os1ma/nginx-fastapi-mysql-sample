#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

readonly SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
readonly PROJECT_HOME="${SCRIPT_DIR}/.."

readonly MAX_RETRY=30
readonly TARGET='localhost:8000/api/posts'

cd "${PROJECT_HOME}"
docker-compose down
docker-compose up -d

for i in $(seq 1 "${MAX_RETRY}"); do
  set +o errexit
  curl -f "${TARGET}"
  curl_result="$?"
  set -o errexit

  if [[ "${curl_result}" -eq 0 ]]; then
    echo 'TEST SUCCEEDED'
    exit 0
  fi

  sleep 1
done

echo 'TEST FAILED'
exit 1
