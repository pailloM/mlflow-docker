FROM python:3.13-slim-bookworm
ENV UV_NO_CACHE=true
ENV UV_COMPILE_BYTECODE=1
ENV MYSQL_USER user
ENV MYSQL_PASSWORD password
ENV MYSQL_DATABASE database
ENV ARTIFACTS_PATH /data
ENV PORT 5051
VOLUME /artifacts
RUN apt update && apt install -y curl && apt clean
RUN rm -rf /var/lib/apt/lists/*
RUN apt clean && apt autoremove
RUN python3 -m pip install --upgrade pip setuptools uv
RUN uv pip install --no-cache mlflow pymysql --system
COPY ./start.sh /opt/mlflow/scripts/
HEALTHCHECK --interval=1m --timeout=10s --start-period=60s CMD curl -f http://localhost:${PORT} || exit 1
# CMD mlflow db upgrade mysql+pymysql://${MYSQL_USER}:${MYSQL_PASSWORD}@mariadb-mlflow/${MYSQL_DATABASE}
ENTRYPOINT ["/bin/bash", "/opt/mlflow/scripts/start.sh"]
