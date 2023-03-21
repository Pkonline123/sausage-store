#!/bin/bash
set +e
cat > .env <<EOF
SPRING_DATASOURCE_URL=${PSQL_DATASOURCE}
SPRING_DATASOURCE_USERNAME=${DATASOURCE_USERNAME}
SPRING_DATASOURCE_PASSWORD=${DATASOURCE_PASSWORD}
SPRING_DATA_MONGODB_URI=${DATA_MONGODB}
REPORT_PATH=./logs
EOF
# docker network rm sausage_network || true
docker network create -d bridge sausage_network || true
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker pull gitlab.praktikum-services.ru:5050/std-013-20/sausage-store/sausage-frontend:latest
docker stop frontend || true
docker rm frontend || true
set -e
docker run -d -p 80:80 --name frontend \
    --network=sausage_network \
    --restart always \
    --pull always \
    --env-file .env \
    gitlab.praktikum-services.ru:5050/std-013-20/sausage-store/sausage-frontend:latest

