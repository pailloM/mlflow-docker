FROM python:3.13-slim-bookworm
ENV UV_NO_CACHE=true
ENV UV_COMPILE_BYTECODE=1
ENV MYSQL_USER user
ENV MYSQL_PASSWORD password
ENV MYSQL_DATABASE database
ENV ARTIFACTS_PATH /data
ENV PORT 5051
VOLUME /artifacts
RUN python3 -m pip install --upgrade pip setuptools uv
RUN uv pip install --no-cache mlflow pymysql --system
HEALTHCHECK --interval=1m --timeout=10s --start-period=60s CMD curl -f http://localhost:${PORT} || exit 1
CMD mlflow db upgrade mysql+pymysql://${MYSQL_USER}:${MYSQL_PASSWORD}@mariadb-mlflow/${MYSQL_DATABASE}
ENTRYPOINT mlflow server --backend-store-uri mysql+pymysql://${MYSQL_USER}:${MYSQL_PASSWORD}@mariadb-mlflow/${MYSQL_DATABASE} --default-artifact-root /artifacts --host 0.0.0.0 --port ${PORT}
