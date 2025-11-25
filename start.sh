#!/bin/bash

mlflow db upgrade mysql+pymysql://${MYSQL_USER}:${MYSQL_PASSWORD}@mariadb-mlflow/${MYSQL_DATABASE}
mlflow server --backend-store-uri mysql+pymysql://${MYSQL_USER}:${MYSQL_PASSWORD}@mariadb-mlflow/${MYSQL_DATABASE} --default-artifact-root /artifacts --host 0.0.0.0 --port ${PORT} --allowed-hosts ${MLFLOW_SERVER_ALLOWED_HOSTS} --cors-allowed-origins ${MLFLOW_SERVER_CORS_ALLOWED_ORIGINS} --x-frame-options ${MLFLOW_SERVER_X_FRAME_OPTIONS}

