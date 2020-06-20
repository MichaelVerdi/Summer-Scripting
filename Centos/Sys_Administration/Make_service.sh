#!/bin/bash
#Made by Michael Verdi
#Script to make a written script a service
echo "Where is the script you want to make the service?"

read var1

chmod +x $var1

cd /etc/systemd/system/

echo "What is the name of this service?"

read var2

touch ${var2}

echo "[Unit]
Description=Description for sample script goes here

After=network.target



[Service]

Type=simple

ExecStart=/var/tmp/test_script.sh

TimeoutStartSec=0



[Install]

WantedBy=default.target" >> ${var2}

mv ${var2} ${var2}.service  


systemctl daemon-reload

systemctl enable ${var2}.service

systemctl start ${var2}.service

