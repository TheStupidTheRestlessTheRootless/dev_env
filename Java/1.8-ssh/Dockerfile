FROM alpine:3.9

RUN apk add --no-cache --upgrade git curl logrotate openjdk8 bash\
    openssh-server openssh-sftp-server sudo && \
    echo "**** setup openssh environment ****" && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config && \
    rm -rf /tmp/*

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE 22

# CMD [ "java", "-version" ]
ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]