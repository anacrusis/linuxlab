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

#addrepo "deb http://download.webmin.com/download/repository sarge contrib"
#addrepo "ppa:freenx-team/ppa"
#sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2a8e3034d018a4ce
#wget http://www.webmin.com/jcameron-key.asc
#apt-key add jcameron-key.asc

if ! grep -x "net.ipv4.ip_forward=1" /etc/sysctl.conf ; then 
	echo "" >> /etc/sysctl.conf
	echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
fi
echo "1" > /proc/sys/net/ipv4/ip_forward 

cp ./etc/network/interfaces /etc/network/interfaces
service networking restart

. server/setup_iptables.sh
iptables-save >/etc/iptables.rules

apt-get -y update

#SQUID

# http://dansguardian.pl/index.php?s=instalacja-5-minutowa
installPackages "dansguardian squid apache2"

#APACHE
sudo ln -s /etc/apache2/mods-available/userdir.load /etc/apache2/mods-enabled/userdir.load
sudo ln -s /etc/apache2/mods-available/userdir.conf /etc/apache2/mods-enabled/userdir.conf
sudo apache2ctl restart

#PASSLESS LOGIN
./server/sshkeys.sh

#wget http://prdownloads.sourceforge.net/webadmin/webmin_1.480_all.deb
#dpkg -i webmin*.deb

#------------------------------------------
# APT CACHER
#cp /etc/apt/apt.conf.d/01proxy /etc/apt/apt.conf.d/01proxy.copy

installPackages "apt-cacher-ng"
echo 'Acquire::http { Proxy "http://localhost:3142"; };' | sudo tee /etc/apt/apt.conf.d/01proxy

#4. Dashboard & manual
#echo "see the apt-cacher-ng dashboard at: <http://localhost:3142/acng-report.html> see apt-cacher-ng User Manual at: (right click at the link and open with your browser): <file:///usr/share/doc/apt-cacher-ng/html/index.html>"

#5. Import .deb files from the local apt cache
test -x /var/cache/apt-cacher-ng/_import || sudo mkdir -p -m 2755 /var/cache/apt-cacher-ng/_import
sudo cp -alf /var/cache/apt/archives/* /var/cache/apt-cacher-ng/_import/
sudo chown -R apt-cacher-ng /var/cache/apt-cacher-ng/_import

echo "click \"start import\" at: <http://localhost:3142/acng-report.html>"

# cleanup and update apt cache index files
#sudo rm -fr /var/cache/apt-cacher-ng/_import
#sudo rm -fr /var/cache/apt/archives/*.deb
#sudo rm /var/cache/apt/*cache.bin
#sudo rm /var/lib/apt/lists/*Packages
#sudo rm /var/lib/apt/lists/*Sources
# http://ubuntuforums.org/showthread.php?t=981085

#------------------------------------------
installPackages "secpanel samba isc-dhcp-server powernap nfs-kernel-server tftpd-hpa"
 
./server/italc.sh
./server/dhcp.sh

cp squid.conf /etc/squid3/squid.conf
restart squid3 

cp dansguardian.conf /etc/dansguardian/
cp dansguardianf1.conf /etc/dansguardian/
cp weightedphraselist /etc/dansguardian/lists/
cat /dev/null > /etc/dansguardian/lists/bannedextensionlist
cat /dev/null > /etc/dansguardian/lists/bannedmimetypelist
mkdir -p /var/log/dansguardian
chown -R proxy:proxy /var/log/dansguardian
service dansguardian restart

cp ./etc/exports /etc/
cp ./etc/default/tftpd-hpa /etc/default/

