FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8-slim

RUN apt update -y \
  && apt install -y gcc libmariadb-dev \
  && pip install mysqlclient
