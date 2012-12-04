#!/bin/bash

if [[ `/usr/bin/id -u` != 0 ]]; then
   exec /usr/bin/sudo $0
fi

BASENAME=`dirname $0`
cd $BASENAME
pwd

LOGFILE="net-dhcp.log"
ifconfig > $LOGFILE
route >> $LOGFILE

chmod a+x correct_permissions.sh
sudo ./correct_permissions.sh

echo "1" > /proc/sys/net/ipv4/ip_forward 

cp etc/network/interfaces.dhcp /etc/network/interfaces
chmod 644 /etc/network/interfaces
chown root /etc/network/interfaces
chgrp root /etc/network/interfaces

cp etc/dhcp3/dhclient.conf /etc/dhcp3/dhclient.conf
chmod 644 /etc/dhcp3/dhclient.conf
chown root /etc/dhcp3/dhclient.conf
chgrp root /etc/dhcp3/dhclient.conf

/etc/init.d/networking restart | tee -a $LOGFILE

if ! ping -q -c 3 192.168.1.1 ; then
	echo "Nie ma polaczenia z neostrada. Sprawdz ustawienia ip i route" | tee -a $LOGFILE
	ifconfig eth0 | tee -a $LOGFILE
	route | tee -a $LOGFILE
fi
if ! ping -q -c 3 208.67.222.222 ; then
	echo "Pakiety nie dochodza na zewnatrz" | tee -a $LOGFILE
else 
	if ! ping -q -c 3 wikipedia.org ; then 
		echo "nie ustawiony dns? albo nie mozna sie polaczyc z wikipedia.org" | tee -a $LOGFILE
		if ! grep -q "208.67.222.222" ; then
			echo "nie ma wpisu w /etc/resolv.conf"
			cat /etc/resolv.conf
			cat /etc/resolv.conf >> $LOGFILE
			echo "nameserver 208.67.222.222" > /etc/resolv.conf
			
		fi
		
	fi
fi


