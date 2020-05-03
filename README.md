# emileet/arch-systemd

the arch experience with systemd in a docker container

## instructions

clone this repo then build a docker image (optionally configure `Dockerfile` to your needs)

```shell
cd arch-systemd
docker build --tag emileet/arch-systemd .
```

now spin up a container (optionally configure `start.sh` to your needs)
```shell
sh start.sh plsnobully
```