#!/bin/bash


cp ./etc/default/isc-dhcp-server /etc/default/isc-dhcp-server
cp ./etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf

/etc/init.d/isc-dhcp-server restart
