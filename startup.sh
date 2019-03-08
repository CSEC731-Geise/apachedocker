#!/bin/bash
set -e 

printf "\n---> Starting the SSH server .\n"

/etc/init.d/ssh start
/etc/init.d/ssh status

printf "\n---> Starting the Apache Server .\n"

/etc/init.d/apache2 start
/etc/init.d/apache2 status

tail -f /dev/null
