# mlflow-docker
Docker container for mlflow

docker-compose exemple:

'''

services:

  mariadb-mlflow:

    container_name: "mariadb-mlflow"

    image: "mariadb:10.11"
    
    environment:
     - "MYSQL_ROOT_PASSWORD=${MARIADB_ROOT_PASSWORD}"
     - "MYSQL_PASSWORD=${MYSQL_PASSWORD}"
     - "MYSQL_DATABASE=mlflow"
     - "MYSQL_USER=${MYSQL_USER}"
    healthcheck:
     test: mariadb-admin ping -h 127.0.0.1 -u $$MYSQL_USER --password=$$MYSQL_PASSWORD
     start_period: 5s
     interval: 5s
     timeout: 5s
     retries: 55

    restart: "unless-stopped"

    volumes:
      - "/etc/localtime:/etc/localtime:ro"
      - "/etc/timezone:/etc/timezone:ro"
      - "path_to_db:/var/lib/mysql"



  mlflow:
    container_name: mlflow
    restart: "unless-stopped"
    image: ghcr.io/paillom/mlflow-docker:main

    ports:
      - "5051:5051"
    
    environment:
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}

    depends_on:
      mariadb-mlflow:
        condition: service_healthy

    volumes:
      - "/etc/localtime:/etc/localtime:ro"
      - "/etc/timezone:/etc/timezone:ro"
      - "path_to_artifacts:/data" # Optional

'''