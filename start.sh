#!/bin/sh
# starts a arch-systemd container

if [[ ! -z $1 ]]; then
    sudo docker run -ti --privileged=true --name $1 -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 8080:80 -d emileet/arch-systemd
else
    echo "please provide a container name"
fi
