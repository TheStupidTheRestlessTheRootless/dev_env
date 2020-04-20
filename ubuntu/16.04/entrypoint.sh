#!/bin/bash

echo "USER_ID=$USER_ID USER_NAME=$USER_NAME" >> /tmp/x.log
echo "GROUP_ID=$GROUP_ID GROUP_NAME=$GROUP_NAME" >> /tmp/x.log
echo "USER_PASSWORD $USER_PWD" >> /tmp/x.log

groupadd -g $GROUP_ID $GROUP_NAME
useradd -s /bin/bash -m -u $USER_ID -g $GROUP_NAME -G sudo $USER_NAME
chown $USER_NAME: /home/$USER_NAME

echo "$USER_NAME:$USER_PWD" | chpasswd

sudo -u $USER_NAME cp /etc/bashrc /home/$USER_NAME/.bashrc
sudo -u $USER_NAME echo "[[ -s ~/.bashrc ]] && source ~/.bashrc" > /home/$USER_NAME/.bash_profile

# run ssh
/usr/sbin/sshd -D