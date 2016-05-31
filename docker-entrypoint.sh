#!/bin/sh
set -e

if [ ! -e /etc/mailhog/passwd ]; then
	PASSWORD=$(/usr/local/bin/mailhog bcrypt ${MAILHOG_PASSWORD})
	echo "${MAILHOG_USERNAME}:${PASSWORD}" > /etc/mailhog/passwd
fi

exec /usr/local/bin/mailhog "$@"