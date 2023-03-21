#!/bin/bash
set +e
cat > .env <<EOF
SPRING_DATASOURCE_URL=jdbc:postgresql://rc1b-txenjeot0qbcbnh3.mdb.yandexcloud.net:6432/std-013-20
SPRING_DATASOURCE_USERNAME=std-013-20
SPRING_DATASOURCE_PASSWORD=P@ssw0rd
SPRING_DATA_MONGODB_URI=mongodb://std-013-20:P%40ssw0rd@rc1a-xb6q7pmw36t77ryz.mdb.yandexcloud.net:27018/std-013-20?tls=true
EOF
# docker network rm sausage_network || true
docker network create -d bridge sausage_network || true
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker pull gitlab.praktikum-services.ru:5050/std-013-20/sausage-store/sausage-frontend:latest
docker stop frontend || true
docker rm frontend || true
set -e
docker run --rm -d -p 80:80 --name frontend \
    --network=sausage_network \
    --restart always \
    --pull always \
    --env-file .env \
    gitlab.praktikum-services.ru:5050/std-013-20/sausage-store/sausage-frontend:latest

