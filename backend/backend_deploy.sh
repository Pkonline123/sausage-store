#!/bin/bash
set +e
echo SPRING_DATASOURCE_PASSWORD=$(vault kv get -field=spring.datasource.password secret/sausage-store) >> /home/deployservice/env_file
echo SPRING_DATASOURCE_USERNAME=$(vault kv get -field=spring.datasource.username secret/sausage-store-username) >> /home/deployservice/env_file
echo SPRING_DATA_MONGODB_URI=$(vault kv get -field=spring.data.mongodb.uri secret/sausage-store-mongo) >> /home/deployservice/env_file
docker network create -d bridge sausage_network || true
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker pull gitlab.praktikum-services.ru:5050/std-013-20/sausage-store/sausage-backend:latest
docker stop backend || true
docker rm backend || true
set -e
docker run -v /home/student/logsBackDocker:/app/logs -d --name backend \
    --network=sausage_network \
    --restart always \
    --pull always \
    --env-file ./env_file \
    gitlab.praktikum-services.ru:5050/std-013-20/sausage-store/sausage-backend:latest
