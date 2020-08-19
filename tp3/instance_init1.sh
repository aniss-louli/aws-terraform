#!/usr/bin/env bash

sudo apt -y update && apt -y upgrade
sudo apt install apache2 -y
sudo apt install php php7.2-bz2 php7.2-zip php7.2-xml php7.2-curl php7.2-bz2 php7.2-zip php7.2-xml php7.2-curl php-mysql -y
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -zxvf latest.tar.gz
sudo mv wordpress /var/www/html/
sudo chown www-data.www-data /var/www/html/wordpress/* -R
cd /var/www/html/wordpress
mv wp-config-sample.php wp-config.php
sed -i -e "s/define( 'DB_NAME', 'database_name_here' )/define( 'DB_NAME', 'wordpress' )/g" wp-config.php 
sed -i -e "s/define( 'DB_USER', 'username_here' )/define( 'DB_USER', 'ubuntu' )/g" wp-config.php 
sed -i -e "s/define( 'DB_PASSWORD', 'password_here' )/define( 'DB_PASSWORD', 'wordpress' )/g" wp-config.php 
sed -i -e "s/define( 'DB_HOST', 'localhost' )/define( 'DB_HOST', '192.168.77.20:3306' )/g" wp-config.php 
sudo systemctl restart apache2
