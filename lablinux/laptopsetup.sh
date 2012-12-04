#!/bin/bash

if [[ `/usr/bin/id -u` != 0 ]]; then
   exec /usr/bin/sudo $0
fi

. ENV_SETTINGS.sh

chmod +x ./linuxsetup.sh
./linuxsetup.sh

echo "KONIEC!"
