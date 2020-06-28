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

   hostname -i = `1`

   sed -i 's/elasticsearch.hosts:/elasticsearch.hosts: "https:$1:9200"
 
   sed -i 's/server.host:/server.host:/server.host: "0.0.0.0" 

   echo "Testing kibana service" 
   
   systemctl enable kibana

   systemctl start kibana

   systemctl status kibana

   echo "Setting up Logstash"

   apt-get install logstash

   cd /etc/logstash/conf.d/

   touch base.conf

   echo 'input { ' >> base.conf
   
   echo '} ' >> base.conf

   echo 'filter {' >> base.conf

   echo '}' >> base.conf

   echo 'output {' >> base.conf

   echo '    elasticsearch { ' >> base.conf

   echo '    hosts -> ["localhost:9200"] ' >> base.conf

   echo '    } ' >> base.conf

   echo '}' >> base.conf

   echo "Installing NGINX"

   apt-get install nginx -y

   sudo -v

   echo "kibadmin:'openssl passwd -apr1'" | sudo tee -a /etc/nginx/htpasswd.users

   mv /etc/nginx/sites-available/default  /etc/nginx/sites-available/original_backup_default

   cd /etc/nginx/sites-available/

   touch default

   echo 'server { ' >> default

   echo '    listen 80;' >> default

   echo '    server_name $1;' >> default

   echo '    auth_basic "Restricted Access"; ' >> default

   echo '    auth_basic_user_file /etc/nginx/htpasswd.users; ' >> default

   echo '    location / { ' >> default

   echo '        proxy_pass http://localhost:5601; ' >> default

   echo '        proxy_http_version 1.1;' >> default

   echo '        proxy_set_header Upgrade $http_upgrade; ' >> default

   echo '        proxy_set_header Connection 'upgrade'; ' >> default

   echo '        proxy_set_header Host $host; ' >> default

   echo '        proxy_cache_bypass $http_upgrade; ' >> default

   echo '   } ' >> default

   echo ' } ' >> default

   echo " Testing Nginx..."

   nginx -t



   



