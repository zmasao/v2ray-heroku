#!/bin/sh

cat << EOF > /etc/v2ray/config.json
{
  "inbounds": [{
    "port": $PORT,
    "protocol": "vmess",
    "settings": {
      "clients": [
        {
          "id": "$UUID",
          "level": 1,
          "alterId": 1
        }
      ]
    },
    "streamSettings": {
      "network": "ws",
      "wsSettings": {
        "path": "/wss"
      }
    },
    "sockopt": {
       "mark": 0,
       "tcpFastOpen": true,
       "tproxy": "off"
    } 
  }],
  "outbounds": [{
    "protocol": "freedom",
    "settings": {}
  },{
    "protocol": "blackhole",
    "settings": {},
    "tag": "blocked"
  }],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": ["geoip:private"],
        "outboundTag": "blocked"
      }
    ]
  }
}
EOF

# Run V2Ray
/usr/bin/v2ray -config /etc/v2ray/config.json
