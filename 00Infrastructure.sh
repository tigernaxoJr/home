#!/bin/bash
chmod a+x *.sh
#docker network create mynetwork --driver bridge --subnet=172.22.0.0/16
docker network create --driver overlay mynetwork --subnet=172.22.0.0/16
#docker network create --driver bridge mynetwork
