FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt -y upgrade
RUN apt install -y apt-utils software-properties-common build-essential apt-transport-https ca-certificates
RUN apt install -y openssh-server sudo vim wget curl
RUN apt install -y zip git

RUN mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
COPY .bashrc /etc/bashrc

EXPOSE 22

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]