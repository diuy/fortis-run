#!/bin/bash
cd $(dirname $0)
APP_HOME=$(pwd)
PIDS=$(ps ax | grep -i "$APP_HOME" | grep java | grep -v grep | awk '{print $1}')

if [ -z "$PIDS" ]; then
    echo "$APP_HOME is not started!"
    exit 1
fi


echo -e "$APP_HOME is stopping ...\c"
kill -s TERM $PIDS

COUNT=0
while [ $COUNT -lt 1 ]; do
    echo -e ".\c"
    sleep 1
    COUNT=1
    for PID in $PIDS ; do
        PID_EXIST=$(ps -f -p $PID | grep java)
        if [ -n "$PID_EXIST" ]; then
            COUNT=0
            break
        fi
    done
done
echo ""
echo "$APP_HOME is stopped"
echo "PID: $PIDS"