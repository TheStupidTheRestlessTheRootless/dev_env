#!/bin/bash

# print help info
display_usage(){
    echo -e "this script is used to build docker image, run docker image and stop container, the container's name is \$USER_dev_env \n"
    echo -e '-s:\t stage, one of build, run and stop, default run'
    echo -e "-n:\t image name, default dev_env"
    echo -e "-t:\t image tag, default latest"
    echo -e "-f:\t force to run the stage"
    echo -e "-p:\t specify local ssh port, default 2222"
}

# default params
stage=run
name=dev_env
tag=latest
force=0
port=2222

# read input params
while getopts "h?s:n:t:fp:" opt; do
    case "$opt" in
        h|\?)
            display_usage
            exit 0
            ;;
        s)  stage=$OPTARG
            ;;
        n)  name=$OPTARG
            ;;
        t)  tag=$OPTARG
            ;;
        f)  force=1
            ;;
        p)  port=$OPTARG
            ;;
    esac
done

image="$name:$tag"
container=${USER}_${name}
# build image stage
build_stage(){
    echo "building ..."
    if [[ "$(docker images -q $image 2> /dev/null)" == "" ]]; then
        # do something
        echo "image not exist"
        docker build -t $image .
    elif [[ "$force" == "1" ]]; then
        echo "force build image"
        docker build -t $image .
    fi

    if [[ "$tag" != "latest" ]];then
        echo "tag latest"
        latest_image="$name:latest"
        docker tag $image $latest_image
    fi
    exit 0;
}

# runt container stage
run_stage(){
    if [[ "$force" == "1" ]];then
    	docker kill $container
    	# docker rm $container
    fi

    pwd=$(openssl rand -base64 16)
    echo "password is: $pwd"

    docker run -d\
           --rm \
           --cap-add SYS_PTRACE \
           -v $HOME:/home/$USER \
           -p $port:22 \
           -e USER_PWD=$pwd\
           -e USER_NAME=$USER -e USER_ID=$UID \
           -e GROUP_NAME=`id -gn $USER` -e GROUP_ID=`id -g $USER` \
           -e seccomp:unconfined \
           -e apparmor:unconfined \
           -v /mnt:/mnt \
           --name $container \
	   $image
    exit 0;
}

# stop container
stop_stage(){
    echo "stopping..."
    docker kill $container
    # docker rm $container
    exit 0;
}

# confirm params
echo -e "stage\t is:\t $stage"
echo -e "tag\t is:\t $tag"
echo -e "name\t is:\t $name"
echo -e "port\t is:\t $port"
read -r -p "Are You Sure? [Y/n] " input
case $input in
    [nN][oO]|[nN])
        echo "Canceled ..."
        exit 1
        ;;
esac

echo "start ..."
[[ "$stage" == "build" ]] && build_stage
[[ "$stage" == "stop" ]] && stop_stage
[[ "$stage" == "run" ]] && run_stage
echo "stage not found"
