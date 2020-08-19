#!/usr/bin/env bash

sudo apt -y update && apt -y upgrade
sudo apt install mariadb-server -y
sudo mysql -e "CREATE DATABASE wordpress CHARACTER SET UTF8 COLLATE UTF8_BIN"
sudo mysql -e "CREATE USER 'ubuntu'@'%' IDENTIFIED BY 'wordpress'"
sudo mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO ubuntu@192.168.77.10 IDENTIFIED by 'wordpress'"
sudo mysql -e "FLUSH PRIVILEGES"
sudo sed -i -e "s/127.0.0.1/0.0.0.0/g" /etc/mysql/my.cnf
sudo systemctl restart mariadb.service                                     
