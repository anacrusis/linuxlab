#!/bin/bash
#set -e
. setup_repositories.sh

aptitude remove -y "~ngnome-games*"

wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list && sudo apt-get --quiet update && sudo apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 

addrepo "http://archive.canonical.com/ubuntu $dist_codename partner"

apt-get update
apt-get -y dist-upgrade

apt-get -y install openssh-server ntfsprogs
apt-get -y install debconf-utils wget

install_packages=" 
aptitude
screen
gparted
non-free-codecs
samba 
p7zip
gimp
build-essential 
inkscape 
bash-completion
mc
vim
kate
sshfs
openssh-server
flashplugin-installer 
wget 
wine 
k3b 
ffmpeg 
ntfsprogs 
vlc 
scilab 
wxmaxima
geogebra
skype
xaralx 
language-pack-pl 
language-support-pl 
language-pack-gnome-pl 
language-pack-kde-pl
libreoffice
openjdk-8-jdk
openjdk-8-jre
"

#qcad texlive kile lyx qtcreator thunderbird

failed_packages=""

for package in $install_packages ; do
	apt-get -y install "$package"
	if [ $? != "0" ]; then 
		failed_packages+=" $package"
	fi
done

apt-get -y autoremove
apt-get -y autoclean

chmod +x accounts.sh
./accounts.sh


if [ -n "$failed_packages" ]; then
echo "

Blad przy instalacji nastepujacych pakietow:

$failed_packages

"

echo "$failed_packages" >BLEDY
exit 1

fi

echo "Pakiety zainstalowane."


