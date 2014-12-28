#!/bin/bash

apt-get install isc-dhcp-server -y

cp ./etc/default/isc-dhcp-server /etc/default/isc-dhcp-server
cp ./etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart
