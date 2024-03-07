#!/bin/bash

# https://github.com/humans/hum/releases/download/latest/hum-cli

ARCHITECTURE=$(uname -m)

if [ $ARCHITECTURE == "x86_64" ]; then
    wget https://dl.static-php.dev/static-php-cli/common/php-8.3.3-micro-linux-x86_64.tar.gz -qO php-micro.tar.gz
fi

if [ $ARCHITECTURE == "arm64" ]; then
    wget https://dl.static-php.dev/static-php-cli/common/php-8.3.3-micro-linux-aarch64.tar.gz -qO php-micro.tar.gz
fi

# apt dist-upgrade
apt update --yes
apt upgrade --yes
apt install ca-certificates apt-transport-https software-properties-common --yes
tar -xvf php-micro.tar.gz
cat php-micro.tar.gz hum-cli > hum
chmod +x hum
service apache2 stop
apt install -y certbot
# ??? apt install python3-certbot-nginx
certbot certonly --nginx -d hum.pigeons.dev --non-interactive --agree-tos -m jaggy@hey.com
hum setup
# nginx
service nginx start
mkdir default
sed -i 's/\/var\/www\/html/\/root\/default/g' /etc/nginx/sites-available/default
# mysql
service mysql start
mysqladmin -uroot password ******
cp
