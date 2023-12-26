#!/bin/bash
COMMAND=${@:-"up -d"}
echo ${COMMAND}
echo docker-compose -f ha/docker-compose.yaml ${COMMAND} 
eval "docker-compose -f ha/docker-compose.yaml ${COMMAND}"
eval "docker-compose -f web/docker-compose.yaml ${COMMAND}"
#docker-compose -f ha/docker-compose.yaml up -d
