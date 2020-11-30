# emileet/arch-systemd
[![pipeline status](https://git.plsnobully.me/emileet/arch-systemd/badges/master/pipeline.svg)](https://git.plsnobully.me/emileet/arch-systemd/-/commits/master)

the arch experience with systemd in a container

## instructions

clone this repo and then build an image

```shell
docker build --tag emileet/arch-systemd --build-arg username=emileet .
```

now spin up a container and execute zsh within it
```shell
docker run -ti --detach --privileged=true \
  -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
  --name arch-systemd \
  emileet/arch-systemd

docker exec -it arch-systemd /bin/zsh
```