#!/bin/bash
apt update
apt install zip apache2 -y
wget https://www.tooplate.com/zip-templates/2132_clean_work.zip
unzip -o 2132_clean_work.zip
cp -r 2132_clean_work/* /var/www/html/
systemctl restart apache2