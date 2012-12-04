#!/bin/bash
#set -e
. setup_repositories.sh

aptitude remove -y "~ngnome-games*"

wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list && sudo apt-get --quiet update && sudo apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 

addrepo "http://archive.canonical.com/ubuntu $dist_codename partner"
addrepo-bin 'http://dl.google.com/linux/deb/ stable non-free'
addrepo-bin 'http://dl.google.com/linux/earth/deb/ stable main'
addrepo-bin 'http://dl.google.com/linux/talkplugin/deb/ stable main'

apt-get update
apt-get -y dist-upgrade

apt-get -y install openssh-server ntfsprogs
apt-get -y install debconf-utils wget

cat preseed.cfg | /usr/bin/debconf-set-selections

apt-get -y install sun-java6-jdk sun-java6-plugin
update-java-alternatives -s java-6-sun


install_packages=" 
aptitude
screen
gparted
libdvdcss2
non-free-codecs
google-earth-stable
nfs-kernel-server
gsmartcontrol
faac
picasa
google-talkplugin
scrot italc-client
smbclient samba smbfs 
p7zip
xsane
ardour
scribus
hugin
gimp
ffmpeg2theora
fluidsynth 
fluid-soundfont-gm 
fluidsynth-dssi 
tuxguitar 
tuxguitar-fluidsynth
mscore
audacity
jackd
kompozer 
blender 
build-essential 
inkscape 
mencoder 
bash-completion
mc
vim
kate
sshfs
scanssh
ssh
flashplugin-installer 
wget 
wine 
k3b 
ffmpeg 
amarok 
ntfsprogs 
kwrite 
adblock-plus 
ubuntu-edu-tertiary 
ubuntu-edu-secondary 
links 
vlc 
mplayer 
wireshark 
goldendict
qtoctave
scilab 
wxmaxima
geogebra
bc
skype
cups
cups-client 
cups-driver-gutenprint 
xaralx 
manpages-pl 
manpages-pl-dev 
language-pack-pl 
language-support-pl 
language-pack-gnome-pl 
language-pack-kde-pl
libreoffice
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

#aptitude remove -y "~ngnome-games*"
#aptitude remove -y "~nkdegames*"

#apt-get -y install sun-java6-jdk sun-java6-plugin
