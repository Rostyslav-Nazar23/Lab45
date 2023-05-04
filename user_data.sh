#!/bin/bash

sudo apt update
sudo apt install apt-transport-https curl gnupg-agent ca-certificates software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt install docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker $USER
newgrp docker
sudo docker run -d --name watchtower -e WATCHTOWER_POLL_INTERVAL=30 -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower
sudo docker run -dp 80:80 --name web rostyslavnazar23/lab45:main