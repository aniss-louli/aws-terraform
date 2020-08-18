## Lancement d'une instance qui fait tourner Apache2, PHP et Wordpress

Après avoir créer la VM sur AWS on se connecte dessus
~~~~
ubuntu@ip-172-31-81-50:~$ sudo apt update && sudo apt upgrade -y
ubuntu@ip-172-31-81-50:~$ sudo apt install apache2 -y
ubuntu@ip-172-31-81-50:~$ sudo apt install php -y
ubuntu@ip-172-31-81-50:~$ sudo apt install php7.2-bz2 php7.2-zip php7.2-xml php7.2-curl php7.2-bz2 php7.2-zip php7.2-xml php7.2-curl php-mysql
ubuntu@ip-172-31-81-50:~$ cd /tmp
ubuntu@ip-172-31-81-50:/tmp$ wget https://wordpress.org/latest.tar.gz
ubuntu@ip-172-31-81-50:/tmp$ tar -zxvf latest.tar.gz
ubuntu@ip-172-31-81-50:/tmp$ sudo mv wordpress /var/www/html/
ubuntu@ip-172-31-81-50:/tmp$ sudo chown www-data.www-data /var/www/html/wordpress/* -R
ubuntu@ip-172-31-81-50:/tmp$ cd /var/www/html/wordpress
ubuntu@ip-172-31-81-50:/var/www/html/wordpress$ mv wp-config-sample.php wp-config.php
ubuntu@ip-172-31-81-50:/var/www/html/wordpress$ vi wp-config.php
define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'ubuntu' );
define( 'DB_PASSWORD', 'wordpress' );
define( 'DB_HOST', '172.31.81.106:3306' );
define( 'DB_CHARSET', 'utf8' );


~~~~


## Lancement d'une instance qui fait tourner MariaDB
~~~~
ubuntu@ip-172-31-81-106:~$ sudo apt update && sudo apt upgrade -y
ubuntu@ip-172-31-81-106:~$ sudo apt install mariadb-server -y
ubuntu@ip-172-31-81-106:~$ sudo mysql_secure_installation
ubuntu@ip-172-31-81-106:~$ sudo mysql
CREATE DATABASE wordpress CHARACTER SET UTF8 COLLATE UTF8_BIN;
CREATE USER 'ubuntu'@'%' IDENTIFIED BY 'wordpress';
GRANT ALL PRIVILEGES ON wordpress.* TO ubuntu@172.31.81.50 IDENTIFIED by "wordpress";
FLUSH PRIVILEGES;


ubuntu@ip-172-31-81-106:~$ sudo vi /etc/mysql/mariadb.conf.d/50-server.cnf 
bind-address                              = 0.0.0.0
~~~~

## Groupes de sécurité

On créé une règle entrante pour la 1ere VM permettant la communication  
Ajouter Tout le trafic - Tous - Tout les ports - Source 172.31.81.106/0  

On créé une règle entrante pour la 2eme VM permettant la communication  
Ajouter Tout le trafic - Tous - Tout les ports - Source 172.31.81.50/0 

On créé une règle entrante pour afficher le wordpress depuis l extérieur 
Ajouter HTTP - TCP - Port 80 - Source 0.0.0.0/0
On peut maintenant atteindre le site http://ec2-3-82-150-12.compute-1.amazonaws.com/wordpress/
