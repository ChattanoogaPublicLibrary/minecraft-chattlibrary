#!/bin/sh
cd /minecraft
exec /sbin/setuser minecraft java -Xmx1024M -Xms1024M -jar minecraft_server.1.8.jar nogui
