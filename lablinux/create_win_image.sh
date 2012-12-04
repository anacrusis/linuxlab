#!/bin/bash

if [[ `/usr/bin/id -u` != 0 ]]; then
   exec /usr/bin/sudo $0
fi

set -e

BASENAME=`dirname $0`
cd $BASENAME
pwd

echo "tworzenie obrazu /dev/sda1 na gimnazjum@192.168.28.1:win.gz "
time ntfsclone --save-image --output - /dev/sda1 | gzip -c | ssh gimnazjum@192.168.28.1 'cat > win.gz'


