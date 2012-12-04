#!/bin/bash

set -e

CLIENTIP="${1:?"Jako argument podaj ip koputera, na ktorym odtwarzamy obraz"}"
echo "adres klienta: $CLIENTIP "



echo "odtwarzanie na $CLIENTIP:/dev/sda1 z gimnazjum@192.168.28.1:win.gz "
menu_lst=`cat menu.lst`
time cat win.gz | ssh gimnazjum@"$CLIENTIP" " tar -xzf - - | ntfsclone --restore-image --overwrite /dev/sda1 - &&

{

update-grub -y

}
"

echo "KONIEC"


