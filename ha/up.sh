#!/bin/bash
cp -r ./config ./volumes
docker-compose up -d && docker-compose logs -f
