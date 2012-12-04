#!/bin/bash

apt-get  -y install italc-master

ica -createkeypair

tar -cjpPf ~/public_html/italckeys /etc/italc/keys/public
chmod a+r ~/public_html/italckeys
chmod -R a+r /etc/italc/keys/private/

