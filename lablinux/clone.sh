#!/bin/bash

if [[ `/usr/bin/id -u` != 0 ]]; then
   exec /usr/bin/sudo $0
fi

set -e

BASENAME=`dirname $0`
cd $BASENAME
pwd

echo "odtwarzanie na /dev/sda1 z gimnazjum@192.168.28.1:win.gz "
time ssh gimnazjum@192.168.28.1  'cat win.gz' | gunzip -c - | ntfsclone --restore-image --overwrite /dev/sda1 -

echo "uaktualnianie menu startowego"

bash ./correct_startup_menu.sh

