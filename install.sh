#!/bin/bash

echo -e "Preparing To Install Example.com"
echo -e "Updating Python Version"
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt install python3.10-dev python3.10-venv python3.10-distutils python3.10-gdbm python3.10-tk python3.10-lib2to
3

echo -e "Installing Web Server Gateway"
sudo apt install python3-pip python3-dev libpq-dev postgresql postgresql-contrib nginx curl -y

echo -e "Creating System Services"
sudo cp gunicorn.socket /etc/systemd/system/
sudo cp gunicorn.service /etc/systemd/system/

echo -e "Configuring Nginx"
sudo freightmatric /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled
sudo ufw allow 'Nginx Full'

echo -e "Enabling and Starting Services"

sudo systemctl start gunicorn.socket
sudo systemctl enable gunicorn.socket
sudo systemctl daemon-reload
sudo systemctl restart gunicorn.socket gunicorn.service
sudo nginx -t && sudo systemctl restart nginx


echo "Installing Certbot"
sudo apt install python3-certbot-nginx -y

echo "SSL Certificates"
sudo certbot --nginx
