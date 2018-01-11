#!/bin/bash
cd $(dirname $0)
APP_HOME=$(pwd)
PIDS=$(ps ax | grep -i "$APP_HOME" | grep java | grep -v grep | awk '{print $1}')

if [ -z "$PIDS" ]; then
    echo "$APP_HOME is stopped!"
else
    echo "$APP_HOME is running! pid: $PIDS"
fi
