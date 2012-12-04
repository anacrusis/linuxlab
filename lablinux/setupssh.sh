#!/bin/bash

if [[ `/usr/bin/id -u` != 0 ]]; then
	exec /usr/bin/sudo $0
fi

apt-get update
apt-get -y install openssh-server 

