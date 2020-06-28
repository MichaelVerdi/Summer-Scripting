#!/bin/bash
#
#
if(( $EUID != 0 )); then

   echo "Please run as sudo user"

   exit

fi

if [ $EUID == 0 ];

then
   
    yum -y install httpd

    systemctl status httpd

    systemctl start httpd

    systemctl enable httpd

    yum -y install epel-release

    yum-config-manager --disable remi-php54

    yum-config-manager --enable remi-php72

    yum install php php-pear php-cgi php-common php-mbstring php-snmp php-gd php-pecl-mysql php-xml php-mysql php-gettext php-bcmath

    cd /etc/

    sed -i 's/date.timezone/date.timezone = New_York/g' php.ini

    yum --enablerepo=remi install mariadb-server

    systemctl start mariadb.service

    systemctl enable mariadb

    mysql_secure_installation

    mysql -u root -p

    Create database zabbixdatabase;

#Take the user inputs and put in command
   
    echo "What Username do you want?"
   
    read user

    echo "What password?"
    
    read password

    create user '$user'@'localhost' identified BY '$password';

    grant all privileges on zabbixlinux.* to zabbixmike@localhost ;

    flush privileges;

    rpm -ivh https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-agent-4.0.17-1.el7.x86_64.rpm

    yum install zabbix-server-mysql zabbix-web-mysql zabbix-agent zabbix-get

    cd /etc/httpd/conf.d/

