FROM phusion/baseimage:0.9.15

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install software-properties-common git -y
RUN apt-add-repository ppa:webupd8team/java -y
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get install oracle-java7-installer -y

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set correct environment variables.
ENV HOME /minecraft
RUN adduser --disabled-password --home=/minecraft --gecos "" minecraft

USER minecraft
ADD https://s3.amazonaws.com/Minecraft.Download/versions/1.8/minecraft_server.1.8.jar /minecraft/
RUN mkdir /minecraft/world
RUN git clone https://github.com/ChattanoogaPublicLibrary/voxel-chattanooga.git /minecraft/world
ADD eula.txt /minecraft/
ADD server.properties /minecraft/


USER root
RUN chown -R minecraft:minecraft /minecraft/
RUN mkdir /etc/service/minecraft
ADD minecraft.sh /etc/service/minecraft/run

CMD ["/sbin/my_init"]