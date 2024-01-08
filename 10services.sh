#!/bin/bash
#COMMAND=${@:-"up -d"}
#echo ${COMMAND}

DIR=$(pwd)
eval "cd ${DIR}/portainer && docker stack deploy -c <(docker-compose config) portainer"
eval "cd ${DIR}/hass && docker stack deploy -c <(docker-compose config) hass"
eval "cd ${DIR}/nginx && docker stack deploy -c <(docker-compose config) nginx"

eval "cd ${DIR}/schedule && docker build -t schedule ."
eval "cd ${DIR}/schedule && docker stack deploy -c <(docker-compose config) schedule"
