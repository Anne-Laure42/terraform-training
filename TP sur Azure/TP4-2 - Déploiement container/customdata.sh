#!/bin/bash

#Installing Docker
sudo apt update &&
sudo apt upgrade -y &&
sudo apt install -y curl ca-certificates lsb-release gnupg &&
sudo curl -fssl https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" &&
sudo apt update -y &&
sudo apt install -y docker-ce containerd.io docker-ce-cli &&
sudo systemctl enable docker
sudo usermod -aG docker $USER

#Create a nginx container
sudo docker run -d --name mynginx -p 8081:80 nginx:latest                                                                                                                                                                                                                                                                
