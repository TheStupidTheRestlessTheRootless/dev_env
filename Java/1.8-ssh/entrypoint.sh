#!/bin/bash


echo "USER_ID=$USER_ID USER_NAME=$USER_NAME" >> /tmp/x.log
echo "GROUP_ID=$GROUP_ID GROUP_NAME=$GROUP_NAME" >> /tmp/x.log
echo "USER_PASSWORD $USER_PWD" >> /tmp/x.log

addgroup -g $GROUP_ID -S $GROUP_NAME 
adduser -u $USER_ID -s /bin/bash -S $USER_NAME -G $GROUP_NAME

echo "$USER_NAME:$USER_PWD" | chpasswd

# run ssh
ssh-keygen -t rsa -P "" -f /etc/ssh/ssh_host_rsa_key
ssh-keygen -t ecdsa -P "" -f /etc/ssh/ssh_host_ecdsa_key
ssh-keygen -t ed25519 -P "" -f /etc/ssh/ssh_host_ed25519_key
/usr/sbin/sshd -D