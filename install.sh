#!/bin/bash

# https://github.com/humans/hum/releases/download/latest/hum-cli

ARCHITECTURE=$(uname -m)

if [ $ARCHITECTURE == "x86_64" ]; then
    wget https://dl.static-php.dev/static-php-cli/common/php-8.3.3-micro-linux-x86_64.tar.gz -qO php-micro.tar.gz
fi

if [ $ARCHITECTURE == "arm64" ]; then
    wget https://dl.static-php.dev/static-php-cli/common/php-8.3.3-micro-linux-aarch64.tar.gz -qO php-micro.tar.gz
fi

tar -xvf php-micro.tar.gz
cat php-micro.tar.gz hum-cli > hum
chmod +x hum
hum
