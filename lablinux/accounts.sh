#!/bin/bash

if [[ `/usr/bin/id -u` != 0 ]]; then
   exec /usr/bin/sudo $0
fi

groupadd -f students

for ((i=0;i<4;++i)); do
	echo "tworzenie student$i"
	
	userdel -f -r "student$i" || true
	useradd -g students -m -G "audio,video,cdrom,plugdev" -s /bin/bash --password "" "student$i" || true
	(echo "student${i}:student${i}")|chpasswd
done

