#! /bin/bash
#Если свалится одна из команд, рухнет и весь скрипт
set -xe
#Перезаливаем дескриптор сервиса на ВМ для деплоя
sudo cp -rf sausage-store-backend.service /etc/systemd/system/sausage-store-backend.service
sudo rm -f /home/jarservice/sausage-store.jar||true
#Переносим артефакт в нужную папку
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store.jar ${NEXUS_REPO_URL}/sausage-store-zachitaylov-andrey-backend/com/yandex/practicum/devops/sausage-store/${VERSION}/sausage-store-${VERSION}.jar
sudo cp ./sausage-store.jar /home/jarservice/sausage-store.jar||true #"<...>||true" говорит, если команда обвалится — продолжай#Обновляем конфиг systemd с помощью рестарта
sudo rm -f /etc/systemd/system/var-file-backend-sausage
(echo "PSQL_HOST=${PSQL_HOST}" && echo PSQL_PORT=${PSQL_PORT} && echo "PSQL_DBNAME=${PSQL_DBNAME}" && echo "PSQL_USER=${PSQL_USER}" && echo "PSQL_PASSWORD=${PSQL_PASSWORD}" && echo "MONGO_USER=${MONGO_USER}" && echo "MONGO_PASSWORD=${MONGO_PASSWORD}" && echo "MONGO_HOST=${MONGO_HOST}" && echo "MONGO_DATABASE=${MONGO_DATABASE}") > var-file-backend-sausage
sudo systemctl daemon-reload
#Перезапускаем сервис сосисочной
sudo systemctl restart sausage-store-backend 
