FROM alpine:3.11

RUN apk add --no-cache --upgrade git curl logrotate nano openjdk8\
    openssh-server openssh-sftp-server sudo && \
    echo "**** setup openssh environment ****" && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config && \
    rm -rf /tmp/*

COPY ../entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE 22

# CMD [ "java", "-version" ]
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]