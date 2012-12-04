#!/bin/bash

if [[ `/usr/bin/id -u` != 0 ]]; then
   exec /usr/bin/sudo $0
fi

BASENAME=`dirname $0`
cd $BASENAME
pwd

rm -rf ~/lablinux
tar -xjpf lablinux.tar.bz2 -C ~/
chmod a+rx ~/lablinux
cd ~/lablinux

bash correct_permissions.sh
./laptopsetup.sh

