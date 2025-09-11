FROM python:3.12-slim-bookworm
ENV UV_NO_CACHE=true
ENV UV_COMPILE_BYTECODE=1
ENV MYSQL_USER user
ENV MYSQL_PASSWORD password
ENV MYSQL_DATABASE database
ENV PORT
RUN python3 -m pip install --upgrade pip setuptools uv
RUN uv pip install --no-cache mlflow pymysql --system
CMD mlflow db upgrade mysql+pymysql://${MYSQL_USER}:${MYSQL_PASSWORD}@mariadb-mlflow/${MYSQL_DATABASE}
ENTRYPOINT command: mlflow server --backend-store-uri mysql+pymysql://${MYSQL_USER}:${MYSQL_PASSWORD}@mariadb-mlflow/${MYSQL_DATABASE} --default-artifact-root /mnt/nfs/mlflow --host 0.0.0.0 --port ${PORT}