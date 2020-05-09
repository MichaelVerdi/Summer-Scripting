


#!/bin/bash




if(( $EUID != 0 )); then
   echo "Please run as sudo user"

   exit
fi


if [ $EUID == 0 ];
then
    echo "Starting setup..."
    
    dhclient
   
    yum install httpd -y
   
    systemctl enable httpd
   
    systemctl start httpd
   
    firewall-cmd --zone=public --permanent --add-port=80/tcp 
   
    firewall-cmd --zone=public --permanent --add-port=443/tcp 
   
    firewall-cmd --reload
fi


if(( `systemctl is-active httpd` == 0 ));
then
   echo "Securing http"
   cd /etc/httpd/conf
   echo 'ServerTokens Prod' >> httpd.conf
   echo 'ServerSignature Off' >> httpd.conf 
   echo 'TraceEnable off' >> httpd.conf
   sed -i '144s/Options Indexes FollowSymLinks/Options None/' httpd.conf
  
   systemctl restart httpd
fi


