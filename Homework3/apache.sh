#!/bin/bash

sudo yum update -y
sudo yum install httpd -y
sudo systemctl enable httpd 
sudo systemctl start httpd

echo "Hello, World!" > /var/www/html/index.html