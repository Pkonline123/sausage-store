#!/bin/bash
set +e
docker network create -d bridge sausage_network || true
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker pull gitlab.praktikum-services.ru:5050/std-013-20/sausage-store/backend-report:latest
docker-compose stop backend-report || true
docker-compose rm backend-report || true
set -e
docker-compose up -d backend-report
# docker run -v /home/student/logsBackDocker:/app/logs -d --name backend-report \
#     --network=sausage_network \
#     --restart always \
#     --pull always \
#     --env-file ./env_file \
#     gitlab.praktikum-services.ru:5050/std-013-20/sausage-store/backend-report:latest
