#!/bin/sh
cd /minecraft
exec /sbin/setuser minecraft java -Xmx2048M -Xms1024M -XX:+UseConcMarkSweepGC -XX:+CMSIncrementalPacing -XX:ParallelGCThreads=2 -XX:+AggressiveOpts -jar minecraft_server.1.7.10.jar nogui
