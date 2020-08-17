Sur la VM hébergée sur AWS

sudo apt install nginx 

systemctl status nginx 
●  nginx.service - A high performance web server and a reverse proxy server
   Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: en
   Active: active (running) since 

curl localhost
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>

Sur la console AWS

Aller dans Groupes de sécurité
Choisir le groupe
Cliquer sur Modifier les règles entrantes
Ajouter HTTP - TCP - Port 80 - Source 0.0.0.0/0
On peut maintenant atteindre le serveur web installé sur la VM à l'adresse :
ec2-54-224-112-80.compute-1.amazonaws.com
