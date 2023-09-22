#!/bin/bash
sudo apt update -y
sudo apt install -y apache2
sudo systemctl enable apache2
sudo chown ubuntu: /var/www/html
echo -e "Hostname: $(hostname) \n" > /var/www/html/index.html
(echo -n "Region: " ; curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}') >> /var/www/html/index.html
sudo systemctl start apache2