#!/bin/bash

# move user data files into one directory
mkdir -p /brightics-studio/userdata/data
touch /brightics-studio/visual-analytics/brightics.db

if [ ! -e /brightics-studio/userdata/brightics.db ] ; then
 mv /brightics-studio/visual-analytics/brightics.db /brightics-studio/userdata/brightics.db
fi
rm /brightics-studio/visual-analytics/brightics.db
ln -s /brightics-studio/userdata/brightics.db /brightics-studio/visual-analytics/brightics.db

if [ ! -n "$(ls -A /brightics-studio/userdata/data)" ] ; then
 mv /brightics-studio/brightics-server/data/* /brightics-studio/userdata/data/
fi
rm -rf /brightics-studio/brightics-server/data
ln -s /brightics-studio/userdata/data /brightics-studio/brightics-server/data

mkdir -p /brightics-studio/brightics-server/logs \
         /brightics-studio/visual-analytics/logs
touch /brightics-studio/brightics-server/logs/brightics-server.log \
      /brightics-studio/visual-analytics/logs/visual-analytics.client.log \
      /brightics-studio/visual-analytics/logs/visual-analytics.error.log \
      /brightics-studio/visual-analytics/logs/visual-analytics.log

sh start-brightics.sh
exec tail -f /brightics-studio/brightics-server/logs/* /brightics-studio/visual-analytics/logs/*
