#!/bin/bash
if [[ `/usr/bin/id -u` != 0 ]]; then
   exec /usr/bin/sudo $0
   fi

if [ -f /boot/grub/menu.lst ]; then
if ! grep -q -x makeactive /boot/grub/menu.lst ; then
sudo cat >> /boot/grub/menu.lst << EOF

title           Window$
rootnoverify    (hd0,0)
savedefault
makeactive
chainloader     +1

EOF
fi

sudo cp /boot/grub/menu.lst '/boot/grub/menu.lst.awk'
sudo awk  '$1 ~ /^default/ {print "default saved"; next} $0 ~ /# howmany=all/ {print "# howmany=2"; next}  $1 ~ /^timeout/ {print "timeout 30"; next} $1 !~ /^hiddenmenu/ {print}' '/boot/grub/menu.lst.awk' > /boot/grub/menu.lst
fi

sudo update-grub -y

