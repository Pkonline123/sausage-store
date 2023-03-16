#!/bin/bash
set +e
cat > .env <<EOF
SPRING_DATASOURCE_URL=${PSQL_DATASOURCE}
SPRING_DATASOURCE_USERNAME=${PSQL_USER}
SPRING_DATASOURCE_PASSWORD=${PSQL_PASSWORD}
SPRING_DATA_MONGODB_URI=${MONGO_DATA}
EOF
docker network create -d bridge sausage_network || true
docker pull gitlab.praktikum-services.ru:5050/std-013-20/sausage-store/sausage-backend:latest
docker stop sausage-backend || true
docker rm sausage-backend || true
set -e
docker run -d --name sausage-backend:latest \
    --network=sausage_network \
    --restart always \
    --pull always \
    --env-file .env \
    gitlab.praktikum-services.ru:5050/std-013-20/sausage-store/sausage-backend:latest
