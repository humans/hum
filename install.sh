#!/bin/bash

# https://github.com/humans/hum/releases/download/latest/hum-cli

apt update --yes
apt install ca-certificates apt-transport-https software-properties-common --yes
apt upgrade --yes

ARCHITECTURE=$(uname -m)

if [ $ARCHITECTURE == "x86_64" ]; then
    wget https://dl.static-php.dev/static-php-cli/common/php-8.3.3-micro-linux-x86_64.tar.gz -qO php-micro.tar.gz
fi

if [ $ARCHITECTURE == "arm64" ]; then
    wget https://dl.static-php.dev/static-php-cli/common/php-8.3.3-micro-linux-aarch64.tar.gz -qO php-micro.tar.gz
fi
tar -xvf php-micro.tar.gz
cat micro.sfx hum-cli > hum
chmod +x hum
mv hum /usr/bin
rm hum-cli micro.sfx php-micro.tar.gz

# Add User
adduser --disabled-password --gecos ""
usermod -aG sudo hum
usermod -aG www-data hum
usermod -aG hum www-data
mkdir /home/hum/.ssh
cp /root/.ssh/* /home/hum/.ssh/
chmod 700 /home/hum/.ssh/
chmod 600 /home/hum/.ssh/*
chown hum:hum /home/hum/.ssh
chown hum:hum /home/hum/.ssh/*
sed -i 's/#PubkeyAuthentication/PubkeyAuthentication/' /etc/ssh/sshd_config
service ssh restart

# Install NGINX
apt install certbot python3-certbot-nginx nginx --yes --quiet --quiet
service apache2 stop
service nginx start
chmod 2750 /home/hum
mkdir /home/hum/default
echo "Hello!" > /home/hum/default/index.html
chown hum:hum /home/hum/default
chown hum:hum /home/hum/default/index.html
sed -i 's/\/var\/www\/html/\/home\/hum\/default/g' /etc/nginx/sites-available/default
service nginx reload


###### mysql
debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"
apt install --yes --quiet --quiet mysql-server
#service mysql start
#mysqladmin -uroot password ******

# add site
#certbot certonly --nginx -d hum.pigeons.dev --non-interactive --agree-tos -m jaggy@hey.com
