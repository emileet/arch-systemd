#!/bin/sh
# starts a arch-systemd container

if [[ ! -z $1 ]]; then
    sudo docker run -ti --privileged=true --name $1 -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /mnt/docker/setup:/setup:rw -p 25591:25565 -p 25590:9090 -d emileet/arch-systemd
else
    echo "please provide a container name"
fi
