#!/bin/bash

apt-get install -y dansguardian

sed -i 's/UNCONFIGURED - Please remove this line after configuration/#UNCONFIGURED - Please remove this line after configuration/g' /etc/dansguardian/dansguardian.conf
sed -r -i "s/^(#)?daemonuser = .*$/daemonuser = 'proxy'/g" /etc/dansguardian/dansguardian.conf
sed -r -i "s/^(#)?daemongroup = .*$/daemongroup = 'proxy'/g" /etc/dansguardian/dansguardian.conf
#sed -i 's/accessdeniedaddress = 'http://YOURSERVER.YOURDOMAIN/cgi-bin/dansguardian.pl'/accessdeniedaddress = 'http://localhost/cgi-bin/dansguardian.pl'/g' /etc/dansguardian/dansguardian.conf

cp dansguardianf1.conf /etc/dansguardian/
cat /dev/null > /etc/dansguardian/lists/bannedextensionlist
cat /dev/null > /etc/dansguardian/lists/bannedmimetypelist
mkdir -p /var/log/dansguardian
chown -R proxy:proxy /var/log/dansguardian

service dansguardian restart

