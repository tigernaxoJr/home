#!/bin/bash
cp -r ./config ./volumes
docker-compose up "$@"
