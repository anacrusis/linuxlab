#!/bin/bash
function addrepo() {
	if echo "$1" |grep "^[[:blank:]]*ppa" ; then 
		add-apt-repository --remove "$1"
		add-apt-repository "$1"
	else
        	add-apt-repository --remove "deb $1"
       		add-apt-repository --remove "deb-src $1"
        	add-apt-repository "deb $1"
	fi
}
function addrepo-bin() {
        addrepo "$1"
        add-apt-repository --remove "deb-src $1"
}
dist_codename="`lsb_release -c -s`"

function installPackages() {
	install_packages="$@"
	failed_packages=""
	for package in $install_packages ; do
		apt-get -y install "$package"
		if [ $? != "0" ]; then
		   failed_packages+=" $package"
    	fi
	done
	echo "$failed_packages"
}

