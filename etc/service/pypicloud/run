#!/bin/sh

# Redirect stderr so everything ends up in the log file
exec 2>&1

if [ ! -e /etc/pypicloud/config.ini ]; then
  echo "You must create a config.ini file and mount it under /etc/pypicloud/"
  exit 1
fi

/env/bin/uwsgi --die-on-term /etc/pypicloud/config.ini
