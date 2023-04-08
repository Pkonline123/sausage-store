#!/bin/bash
set +e
# docker network rm sausage_network || true
docker network create -d bridge sausage_network || true
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker pull gitlab.praktikum-services.ru:5050/std-013-20/sausage-store/sausage-frontend:latest
docker compose stop frontend || true
docker compose rm frontend || true
set -e
docker compose up frontend
# docker run -d -p 80:80 --name frontend \
#     --network=sausage_network \
#     --restart always \
#     --pull always \
#     gitlab.praktikum-services.ru:5050/std-013-20/sausage-store/sausage-frontend:latest

