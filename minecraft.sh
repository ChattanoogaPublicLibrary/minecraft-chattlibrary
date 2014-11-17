#!/bin/sh
cd /minecraft
exec /sbin/setuser minecraft screen -dmS minecraft java -Xms1024M -Xmx1024M -jar minecraft_server.jar nogui
