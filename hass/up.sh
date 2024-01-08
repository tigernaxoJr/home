#!/bin/bash
cp -r ./mosquitto ./volume
docker-compose up -d && docker-compose logs -f
