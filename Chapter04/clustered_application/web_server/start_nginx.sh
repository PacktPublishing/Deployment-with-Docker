#!/bin/bash -e

export DNS_RESOLVERS=$(cat /etc/resolv.conf | grep 'nameserver' | awk '{ print $2 }' | xargs echo)

cat /etc/nginx/conf.d/nginx_main_site.conf.template | envsubst '$DNS_RESOLVERS $APP_NAME' > /etc/nginx/conf.d/nginx_main_site.conf

cat /etc/nginx/conf.d/nginx_main_site.conf

nginx -g 'daemon off;'
