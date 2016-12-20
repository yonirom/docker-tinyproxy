#!/bin/bash
default_route_interface=$(netstat -rnf inet | grep ^default | awk '{print $6}' )
network_service=$(networksetup -listnetworkserviceorder | awk '/'${default_route_interface}'/{if (a) print a} {a=$2}')
external_ip=$(curl -s canhazip.com)

current_http_proxy_enabled=$(networksetup getwebproxy ${network_service} | grep ^Enabled | awk -F': ' '{print $2'})
current_http_proxy_server=$(networksetup getwebproxy ${network_service} | grep ^Server | awk -F': ' '{print $2'})
current_http_proxy_port=$(networksetup getwebproxy ${network_service} | grep ^Port | awk -F': ' '{print $2'})
current_http_proxy_auth=$(networksetup getwebproxy ${network_service} | grep ^Authenticated | awk -F': ' '{print $2'})

echo "${default_route_interface} ${network_service} ${external_ip}"
echo "Current http settings: ${current_http_proxy_enabled} $current_http_proxy_server $current_http_proxy_port $current_http_proxy_auth"


free_fip=$(hyper fip ls | awk '!$2 {print $1}' | head -1)

if [[ ${free_fip} == '' ]]; then
        echo "No Free fips"
        exit 1
fi

echo "Found free fip: $free_fip"


# networksetup -setwebproxy ${network_service} 12.0.0.1 8888
# networksetup -setwebproxystate ${network_service} off
