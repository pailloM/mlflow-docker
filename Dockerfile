FROM python:3.12-slim-bookworm
ARG VERSION
ENV UV_NO_CACHE=true
ENV UV_COMPILE_BYTECODE=1
RUN python3 -m pip install --upgrade pip setuptools uv
RUN uv pip install --no-cache mlflow==${VERSION} pymysql --system