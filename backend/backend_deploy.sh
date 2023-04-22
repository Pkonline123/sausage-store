#!/bin/bash
set +e
docker network create -d bridge sausage_network || true
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
if [ "$( docker container inspect -f '{{.State.Running}}' blue )" == "true" ]; then
    docker pull gitlab.praktikum-services.ru:5050/std-013-20/sausage-store/sausage-backend:latest    
    docker stop green || true
    docker rm -f green || true
    set -e
    docker-compose up -d backend_green
    # while [ $(docker exec -it green curl --fail -s http://localhost:8080/actuator/health) != {"status":"UP"} ]
    # do
    #         echo unhealthy
    # done
    docker stop blue || true
    docker rm -f blue || true
elif [ "$( docker container inspect -f '{{.State.Running}}' green )" == "true" ]; then
    docker pull gitlab.praktikum-services.ru:5050/std-013-20/sausage-store/sausage-backend:latest    
    docker stop blue || true
    docker rm -f blue || true
    set -e
    docker-compose up -d backend_blue
    # while [ $(docker exec -it green curl --fail -s http://localhost:8080/actuator/health) == {"status":"UP"} ]
    # do
    #         echo unhealthy
    # done
    docker stop green || true
    docker rm -f green || true
fi
# docker pull gitlab.praktikum-services.ru:5050/std-013-20/sausage-store/sausage-backend:latest
# docker-compose stop backend_blue || true
# docker-compose rm -f backend_blue || true
# set -e
# docker-compose up -d backend_blue
# docker run -v /home/student/logsBackDocker:/app/logs -d --name backend \
#     --network=sausage_network \
#     --restart always \
#     --pull always \
#     --env-file ./env_file \
#     gitlab.praktikum-services.ru:5050/std-013-20/sausage-store/sausage-backend:latest
