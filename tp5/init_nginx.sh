
sudo apt-get install -y nginx,
sudo mv /home/roote/gits/aws-terraform2/TP5/Scripts/nginx.conf /etc/nginx/sites-available/nginx.conf
sudo ln -s /etc/nginx/sites-available/oink /etc/nginx/sites-enabled/oink
sudo rm /etc/nginx/sites-enabled/default
sudo systemctl reload nginx


if systemctl status nginx ; then
    echo "Command succeeded"
else
    echo "Command failed / Nginx is not installed"
fi


curl http://your_server_ip > /tmp/cloud-init-nginx.log

cd nginx/etc/ssl

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout private/nginx-selfsigned.key \
    -out ./nginx-selfsigned.crt


openssl dhparam -out dhparam.pem 2048