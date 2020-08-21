sudo apt install nginx -y
sudo mv /media/backup/aws-terraform/tp5/nginx.conf /etc/nginx/sites-available/nginx.conf
sudo ln -s /etc/nginx/sites-available/oink /etc/nginx/sites-enabled/oink
sudo rm /etc/nginx/sites-enabled/default
sudo systemctl reload nginx


if systemctl status nginx ; then
    echo "Command succeeded"
else
    echo "Command failed / Nginx is not installed"
fi


curl 192.168.0.10 > /tmp/cloud-init-nginx.log

cd nginx/etc/ssl

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout private/nginx-selfsigned.key \
    -out ./nginx-selfsigned.crt


openssl dhparam -out dhparam.pem 2048
