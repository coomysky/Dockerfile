#!/bin/bash

echo "Update and add lastest docker repo ..."
sudo apt-get -qq update
sudo apt-get -qqy install apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo bash -c "echo \"deb https://apt.dockerproject.org/repo ubuntu-trusty main\" > /etc/apt/sources.list.d/docker.list"

echo "Install linux image ..."
sudo apt-get -qq update
sudo apt-get purge lxc-docker
sudo apt-cache policy docker-engine
sudo apt-get -qqy install linux-image-extra-$(uname -r)

echo "Install docker ..."
sudo apt-get -qq update
sudo apt-get -qqy install docker-engine
sudo service docker start

echo "Add user to docker group"
sudo usermod -aG docker $(echo $HOME | awk -F "/" '{print $3}')

echo "Pulling docker images ..."
sudo docker pull coomy/develop:node
sudo docker pull coomy/apache2:php5
sudo docker pull phpmyadmin/phpmyadmin
sudo docker pull mysql

echo "Create docker volumes ..."
mkdir -p $HOME/Docker/volume/apache2_php5/log
mkdir -p $HOME/Docker/volume/dev_node/code

echo "Start mysql container ..."
sudo docker run -d --restart=always -p 3306:3306 -e MYSQL_ROOT_PASSWORD=ubuntu --name mysql mysql:latest mysqld

echo "Start apache2_php5 container ..."
sudo docker run -d --restart=always -p 80:80 -v $HOME/Docker/volume/apache2_php5/log:/var/log/apache2 -v $HOME/Docker/volume/dev_node/code:/var/www --name apache2_php5 -h apache2-php5 coomy/apache2:php5 /bin/bash /root/start.bash

echo "Start dev_node container ..."
sudo docker run -d --restart=always -p 33:22 -p 3000:3000 -v $HOME/Docker/volume/dev_node/code:$HOME/code -e NODE_PACKAGE="gulp bower" --name dev_node -h dev-node coomy/develop:node /bin/bash /home/ubuntu/start/run.bash

echo "Start phpMyAdmin container ..."
sudo docker run -d --restart=always -p 8080:80 -e PMA_HOST=mysql --link mysql:pma_db --name phpMyAdmin phpmyadmin/phpmyadmin:latest

echo "Installation Done!!!"
echo "Rebootting ..."
sudo reboot

