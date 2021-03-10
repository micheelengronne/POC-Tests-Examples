#!/bin/bash

yum install -y python36 git yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io
systemctl start docker
curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
echo 'Monitoring steps -----------------'
echo 'Software and app'
cd /vagrant/grafana
echo admin user: admin
echo admin password: admin
/usr/local/bin/docker-compose up -d
#echo 'Monitoring steps -----------------'
#echo 'Log'
#cd /root
#git clone https://github.com/kzk/docker-compose-efk.git
#cd docker-compose-efk
#/usr/local/bin/docker-compose up -d
#ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
