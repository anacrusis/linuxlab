#!/bin/bash

apt-get install -y squid
sed -r -i "s/^http_port.*$/http_port 3128/g" /etc/squid3/squid.conf
sed -r -i 's/^[#]?\W*always_direct allow local-servers.*$/alwaywqs_direct allow all/g' /etc/squid3/squid.conf
service squid3 restart

