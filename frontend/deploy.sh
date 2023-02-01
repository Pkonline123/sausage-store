#! /bin/bash
#Если свалится одна из команд, рухнет и весь скрипт
set -xe
#Перезаливаем дескриптор сервиса на ВМ для деплоя
sudo cp -rf sausage-store-frontend.service /etc/systemd/system/sausage-store-frontend.service
sudo rm -r /var/www-data/dist/frontend||true
sudo rm -f ./sausage-store.tar.gz||true
#Переносим артефакт в нужную папку
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store.tar.gz ${NEXUS_REPO_URL}/sausage-store-zachitaylov-andrey-frontend/sausage-store/${VERSION}/sausage-store-${VERSION}.tar.gz
sudo tar xzf sausage-store.tar.gz -C /var/www-data/dist/||true
sudo systemctl daemon-reload
#Перезапускаем сервис сосисочной
sudo systemctl restart sausage-store-frontend 
