#!/bin/sh
set -e

# change uid/gid of www-data
CURRENT_UID=$(id -u www-data)
CURRENT_GID=$(id -g www-data)
if [ ! -z "$UID" ] && [ "$UID" -ne $CURRENT_UID ]; then
    echo "Change UID of www-data from $CURRENT_UID to $UID"
    usermod -u $UID www-data
    find / -xdev -user $CURRENT_UID -exec chown -h www-data {} \;
fi
if [ ! -z "$GID" ] && [ "$GID" -ne $CURRENT_GID ]; then
    echo "Change GID of www-data from $CURRENT_GID to $GID"
    groupmod -g $GID www-data
    find / -xdev -group $CURRENT_GID -exec chgrp -h www-data {} \;
fi

# upstream entrypoint (php:*-apache)
exec docker-php-entrypoint $@