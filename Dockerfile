FROM phusion/baseimage:0.9.15

RUN apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install software-properties-common git openjdk-7-jre wget -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  adduser --disabled-password --home=/minecraft --gecos "" minecraft && \
  wget -P /minecraft https://s3.amazonaws.com/Minecraft.Download/versions/1.7.10/minecraft_server.1.7.10.jar && \
  mkdir /minecraft/world && \
  git clone https://github.com/ChattanoogaPublicLibrary/voxel-chattanooga.git /minecraft/world && \
  mkdir /etc/service/minecraft


ENV HOME /root

ADD server.properties  /minecraft/
ADD whitelist.json  /minecraft/
ADD ops.json /minecraft/
ADD banned-ips.json  /minecraft/
ADD banned-players.json /minecraft/
ADD eula.txt /minecraft/
ADD minecraft.sh /etc/service/minecraft/run

CMD ["/sbin/my_init"]

RUN chown -R minecraft:minecraft /minecraft/

EXPOSE 25565
