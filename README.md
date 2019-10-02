# dev_env_dockerfile

basic develop environment based on ubuntu18.04

## features

1. run ssh server on startup
2. create user with the same user id and group id as current local user
3. run build image, start server and stop server with run_env.sh, use `run_env.sh -h`
   for help
4. install some default software: openjdk11, git, vim, emacs26

create a fork or new branch if you want to add your own softwares.
