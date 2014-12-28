#!/bin/bash
if [[ `/usr/bin/id -u` != 0 ]]; then
   exec /usr/bin/sudo $0
fi

#set -e

BASENAME=`dirname $0`
cd "$BASENAME"
pwd

chmod a+x correct_permissions.sh
sudo ./correct_permissions.sh

. setup_repositories.sh
cp server/etc/apt/sources.list.d/drlb.list /etc/apt/sources.list.d/drlb.list

cp server/etc/sysctl.d/60-lab.conf /etc/sysctl.d/60-lab.conf 
sysctl --system 

cp server/etc/network/if-up.d/iptablesload /etc/network/if-up.d/iptablesload
cp server/etc/network/interfaces /etc/network/interfaces
. server/setup_iptables.sh
iptables-save >/etc/iptables.rules

apt-get -y update

./server/squid.sh
./server/dansguardian.sh

installPackages "apache2"
a2enmod userdir

#PASSLESS LOGIN
./server/sshkeys.sh

installPackages "samba powernap nfs-kernel-server tftpd-hpa"
 
#./server/italc.sh
./server/dhcp.sh

cp ./etc/exports /etc/
cp ./etc/default/tftpd-hpa /etc/default/

installPackages "intel-microcode"


