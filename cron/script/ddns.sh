#!/bin/bash
get_public_ip(){
  local url="https://api64.ipify.org?format=json"
  echo $(curl -s ${url} | jq -r .ip)
}
get_zone_id(){
  local url="https://api.cloudflare.com/client/v4/zones?name=${zone}"
  local result=$(curl ${url}  --header "Authorization: Bearer ${token}")
  echo $result | jq -r  '.result[] | select(.name == "'$zone'") | .id' 
}
ddns_update(){
  # 取得 zone_id
  local zone_id=$(get_zone_id)
  echo "zone_id: $zone_id"

  # 取得 dns_records
  local url_get_dns="https://api.cloudflare.com/client/v4/zones/${zone_id}/dns_records?type=A&comment.startswith=home"
  local result=$(curl --location --request GET "${url_get_dns}" \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer ${token}" \
    --data '{ "type": "A" }')

  # 使用 jq 從 A Record 提取 dns_records, old_ip(cloudflare 當前設置的 ip)
  local old_ip=$(echo "$result" | jq -r '.result[] | select(.name == "'${name}.${zone}'") | .content')
  local dns_records=$(echo "$result" | jq -r '.result[] | select(.name == "'${name}.${zone}'") | .id')
  local current_ip=$(get_public_ip)

  echo "old_ip:$old_ip"
  echo "dns_records:$dns_records"
  echo "current_ip:$current_ip"

  # Compare IP
  local saved_ip=$(cat public_ip 2>/dev/null || echo "")
  if [ "${current_ip}" == "${old_ip}" ]; then
    return 0
  fi

  # 更新
  local url_update="https://api.cloudflare.com/client/v4/zones/${zone_id}/dns_records/${dns_records}"
  curl --location --request PUT "${url_update}" \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer ${token}" \
    --data '{
      "content": "'"${current_ip}"'",
      "name": "home",
      "proxied": false,
      "type": "A",
      "comment": "home",
      "tags": [],
      "ttl": 1
    }'
}
ddns_update
