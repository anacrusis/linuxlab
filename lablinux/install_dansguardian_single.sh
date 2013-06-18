#!/bin/bash
if [[ `/usr/bin/id -u` != 0 ]]; then
   exec /usr/bin/sudo $0
fi

#set -e

BASENAME=`dirname $0`
cd "$BASENAME"
pwd

chmod a+x correct_permissions.sh
sudo ./correct_permissions.sh

. setup_repositories.sh
