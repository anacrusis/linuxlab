#!/bin/bash

apt-get  -y install italc-client

rm italckeys || true
wget "http://$SERVER_IP/~gimnazjum/italckeys"

tar -xjpPf italckeys

chmod -R a+r /etc/italc/keys/public/

