#!/bin/bash
#Written by Michael Verdi
#Single Node Elk Stack


if(( $EUID != 0 )); then
  echo "Please run as Sudo User"
  
  exit

fi

if [ $EUID == 0 ];

then
  
   echo "Beginning Elk Build..."
   
   sudo apt-get update   

   sudo add-apt-repository ppa:webupd8team/java
   
   sudo apt-get install oracle-java8-installer
  
   wget -q0 - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

   apt-get install apt-transport-https

   echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list

   apt-get update && apt-get install elasticsearch
   
   sudo vi /etc/elasticsearch/elasticsearch.yml
   
   echo "Testing elasticsearch"
  
   systemctl enable elasticsearch

   systemctl start elasticsearch
  
   systemctl status elasticsearch

   echo "Setting up Kibana"
   
   apt get update && apt-get install kibana

   sudo vi /etc/kibana/kibana.yml
 
   echo "Testing kibana service" 
   
   






