FROM phusion/baseimage:0.9.15

MAINTAINER Sean Brewer <sbrewer@lib.chattanooga.gov>

RUN apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install software-properties-common git openjdk-7-jre wget -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  adduser --disabled-password --home=/minecraft --gecos "" minecraft && \
  wget -P /minecraft https://s3.amazonaws.com/Minecraft.Download/versions/1.7.10/minecraft_server.1.7.10.jar && \
  mkdir /minecraft/data && \
  mkdir /etc/service/minecraft && \
  mkdir /minecraft/data/logs

VOLUME ['/minecraft/data']

ENV HOME /root

RUN ln -s /minecraft/data/server.properties /minecraft/server.properties && \
  ln -s /minecraft/data/whitelist.json /minecraft/whitelist.json && \
  ln -s /minecraft/data/ops.json /minecraft/ops.json && \
  ln -s /minecraft/data/banned-ips.json /minecraft/banned-ips.json && \
  ln -s /minecraft/data/banned-players.json /minecraft/banned-players.json && \
  ln -s /minecraft/data/eula.txt /minecraft/eula.txt && \
  ln -s /minecraft/data/logs /minecraft/logs && \
  ln -s /minecraft/data/world /minecraft/world

ADD minecraft.sh /etc/service/minecraft/run

CMD ["/sbin/my_init"]

RUN chown -R minecraft:minecraft /minecraft/

EXPOSE 25565
