#!/bin/zsh

php hum-cli app:build hum-cli
wget https://dl.static-php.dev/static-php-cli/common/php-8.3.3-micro-linux-x86_64.tar.gz -O php-micro.tar.gz
tar -xvf php-micro.tar.gz
cat micro.sfx ./builds/hum-cli > ./builds/hum
rm php-micro.tar.gz
rm micro.sfx
rm ./builds/hum-cli

