#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io git
echo Creating docker group if needed...
sudo usermod -aG docker vagrant
sudo apt-get install -y python3-pip
sudo python3 -m pip install --upgrade pip
sudo pip3 install docker-compose
echo 'Monitoring steps -----------------'
echo 'End to End'
cd /root
git clone https://github.com/micheelengronne/docker.git
cd docker/.examples/nginx
docker-compose up -d
echo "You should alter the config.ini.php file"
# docker cp nginx_app_1:/var/www/html/config/config.ini.php config.ini.php
# sed -i 's/trusted_hosts[] = "localhost"/trusted_hosts[] = "localhost:8085"/g' config.php
# docker cp config.ini.php nginx_app_1:/var/www/html/config/config.ini.php
