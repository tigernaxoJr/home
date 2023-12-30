#!/bin/bash
# 更新憑證
docker run --rm -v /etc/letsencrypt:/etc/letsencrypt -v /usr/share/nginx/html:/html -ti certbot/certbot renew
# 重啟 nginx
eval "docker-compose -f web/docker-compose.yaml up -d"
