#!/bin/bash

mlflow db upgrade mysql+pymysql://${MYSQL_USER}:${MYSQL_PASSWORD}@mariadb-mlflow/${MYSQL_DATABASE}
mlflow server --backend-store-uri mysql+pymysql://${MYSQL_USER}:${MYSQL_PASSWORD}@mariadb-mlflow/${MYSQL_DATABASE} --default-artifact-root /artifacts --host 0.0.0.0 --port ${PORT}

