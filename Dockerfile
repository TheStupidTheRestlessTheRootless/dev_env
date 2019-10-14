FROM ubuntu:18.04

# disable interactive config
ENV DEBIAN_FRONTEND=noninteractive
COPY sources.list /etc/apt/

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y apt-utils software-properties-common build-essential apt-transport-https ca-certificates
RUN apt-get install -y openssh-server rsync busybox sudo
RUN apt-get install -y autoconf libtool git pkg-config curl
RUN apt-get install -y curl wget tmux vim rsync

RUN add-apt-repository ppa:kelleyk/emacs
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update -q && \
        apt-get install -y emacs26 openjdk-11-jdk

RUN apt-get install -y htop
RUN apt-get install -y global


# sshd config
RUN mkdir /var/run/sshd
RUN echo "root:root" | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# 22 for ssh server
EXPOSE 22


COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
# CMD    ["/usr/sbin/sshd", "-D"]
