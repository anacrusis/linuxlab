#!/bin/bash

if [[ `/usr/bin/id -u` != 0 ]]; then
   exec /usr/bin/sudo $0
fi

BASENAME=`dirname $0`
cd $BASENAME
pwd

chmod a+x correct_permissions.sh
sudo ./correct_permissions.sh

echo "1" > /proc/sys/net/ipv4/ip_forward 

cp ./etc/network/interfaces /etc/network/interfaces
/etc/init.d/networking restart

echo "nameserver 208.67.222.222" > /etc/resolv.conf

