# dev_env

basic develop environment based on ubuntu18.04

## features

1. run ssh server on startup
2. create user with the same user id and group id as current local user
3. run build image, start server and stop server with run_env.sh, use `run_env.sh -h`
   for help
4. install some default software: openjdk11, git, vim, emacs26

create a fork or new branch if you want to add your own softwares.

## ubuntu ssh server docker-compose.yml demo

```
version: "3.0"
services:
  java-ssh:
    image: image_name
    container_name: ssh-server-16.04
    environment:
      - USER_ID=local_user_id
      - USER_NAME=local_user_name
      - GROUP_ID=local_group_id
      - GROUP_NAME=local_group_name
      - USER_PWD=user_password #optional
    volumes:
      - /path/to/your/data:/data
      - /mnt:/mnt
      - /run/dbus/system_bus_socket:/run/dbus/system_bus_socket:ro
      - "/etc/timezone:/etc/timezone:ro"
      - "/etc/localtime:/etc/localtime:ro"
    ports:
      - "2222:22"
    restart: always
    privileged: true

```