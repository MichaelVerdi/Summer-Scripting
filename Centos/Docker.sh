#!/bin/bash
#Written by Micvhael Verdi
#Set up a Docker Environment

if(( $EUID != 0 )); then
  echo "Please run as sudo user"
  exit
fi

if [ $EUID == 0 ];
then

   echo "Setting up Docker Environment"
   
   apt update
   
   apt install  apt-transport-https ca-certificates curl software-properties-common
   
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  
   sudo apt update
   
   apt-cache policy docker-ce

   apt install docker-ce
   
   systemctl status docker

fi

if(( `systemctl is-active docker` == 0 ));
then
   echo "Installing Docker-Compose"
  
   curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

   chmod +x /usr/local/bin/docker-compose

   docker-compose --version
fi


