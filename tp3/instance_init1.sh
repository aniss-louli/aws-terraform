#!/usr/bin/env bash

apt -y update && apt -y upgrade
sudo apt install apache2 -y
sudo apt install php -y
sudo apt install php7.2-bz2 php7.2-zip php7.2-xml php7.2-curl php7.2-bz2 php7.2-zip php7.2-xml php7.2-curl php-mysql
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -zxvf latest.tar.gz
sudo mv wordpress /var/www/html/
sudo chown www-data.www-data /var/www/html/wordpress/* -R
cd /var/www/html/wordpress
mv wp-config-sample.php wp-config.php

