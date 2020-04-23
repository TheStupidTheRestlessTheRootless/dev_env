FROM node:12.16.2-alpine3.11

RUN apk add --no-cache --upgrade git curl logrotate bash\
    openssh-server openssh-sftp-server sudo && \
    echo "**** setup openssh environment ****" && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config && \
    rm -rf /tmp/*
RUN apk add shadow
COPY .bashrc /etc/bash.bashrc
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE 22

# CMD [ "java", "-version" ]
ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]
