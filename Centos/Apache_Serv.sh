#!/bin/bash
#Written By Michael Verdi
#Designed to set up a basic hardened Apache server on Centos 7 minimal


if(( $EUID != 0 )); then
   echo "Please run as sudo user"

   exit
fi

#Initial firewall and Apache server setup, no data is added 
if [ $EUID == 0 ];
then
    echo "Starting setup..."
    
    yum install httpd -y
   
    systemctl enable httpd
   
    systemctl start httpd
   
    firewall-cmd --zone=public --permanent --add-port=80/tcp 
   
    firewall-cmd --zone=public --permanent --add-port=443/tcp 
   
    firewall-cmd --reload
fi

#Hardening for Tokens, directory traversal and Options
if(( `systemctl is-active httpd` == 0 ));
then
   echo "Securing http"
   
   cd /etc/httpd/conf
   
   echo 'ServerTokens Prod' >> httpd.conf
   
   echo 'ServerSignature Off' >> httpd.conf 
   
   echo 'TraceEnable off' >> httpd.conf
   
   echo 'FileETag None' >> httpd.conf
  
   printf "<LimitExcept GET POST HEAD>\ndeny from all\n</LimitExcept>\n" >> httpd.conf

   echo 'TraceEnable off' >> httpd.conf

   echo 'Header edit Set-Cookie ^(.*)$ $1;HttpOnly;Secure' >> httpd.conf 

   sed -i '144s/Options Indexes FollowSymLinks/Options None/' httpd.conf
   
   systemctl restart httpd

fi
#Install Mod security
if(( `systemctl is-active httpd` == 0 ));
then
  echo "Making and disabling base webpages"
  
  echo "This Page was made from your script">/var/www/html/index.html
  
  cd /etc/httpd/conf.d
  
  mv welcome.conf old_hpage
  
  yum install mod_security -y
  
  cd /etc/httpd/conf.d
  
  httpd -M | grep security
  
  systemctl restart httpd
 
  tail /etc/httpd/logs/error_log

fi

if (( `systemctl is-active httpd` == 0 ));
then
  echo "Post Mod security Work..."

fi  
