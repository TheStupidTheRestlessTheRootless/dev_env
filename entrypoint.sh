#!/bin/bash

echo "USER_ID=$USER_ID USER_NAME=$USER_NAME" >> /tmp/x.log
echo "GROUP_ID=$GROUP_ID GROUP_NAME=$GROUP_NAME" >> /tmp/x.log
echo "CONTAINER_SRC_ROOT $CONTAINER_SRC_ROOT" >> /tmp/x.log
echo "USER_PASSWORD $USER_PWD" >> /tmp/x.log

groupadd -g $GROUP_ID $GROUP_NAME
useradd -s /bin/bash -m -u $USER_ID -g $GROUP_NAME -G sudo $USER_NAME
echo "$USER_NAME:$USER_PWD" | chpasswd

echo "User & group created " >> /tmp/x.log

if [[ -z "$1" ]]; then
    # run ssh
    /usr/sbin/sshd -D
else
    # run command as host user
    echo "CONTAINER_SRC_ROOT $CONTAINER_SRC_ROOT"
    sudo -H -u $USER_NAME bash -c "cd $CONTAINER_SRC_ROOT;$@"
    ERRORCODE="$?"
    exit $ERRORCODE
fi
