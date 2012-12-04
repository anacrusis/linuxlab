#!/bin/bash

if [[ `/usr/bin/id -u` != 0 ]]; then
	echo "Wpisz haslo:"
	exec /usr/bin/sudo $0
fi

#set -e

. ENV_SETTINGS.sh

echo "Acquire::http { Proxy \"http://$SERVER_IP:3142\"; };" | sudo tee /etc/apt/apt.conf.d/01proxy

chmod +x ./linuxsetup.sh
./linuxsetup.sh

rm id_rsa.pub || true
wget "http://$SERVER_IP/~gimnazjum/id_rsa.pub"

echo "root:rootpassword" | chpasswd

mkdir -p ~/.ssh

if ! grep -q -f id_rsa.pub ~/.ssh/authorized_keys ; then
	echo "" >> ~/.ssh/authorized_keys
	cat id_rsa.pub >> ~/.ssh/authorized_keys
fi
rm  id_rsa.pub

./client/italc.sh

/usr/lib/lightdm/lightdm-set-defaults -s ubuntu-2d

echo "KONIEC!"
