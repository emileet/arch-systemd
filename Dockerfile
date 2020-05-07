FROM archlinux/base:latest
MAINTAINER Emily Maré (emileet) <emileet@plsnobully.me>

# install useful packages
RUN pacman -Syyu --noconfirm && \
    pacman -S awk git nano rxvt-unicode sudo zsh --noconfirm && \
    pacman -Scc --noconfirm && \

# fix systemd
RUN rm -f /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* && \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl* && \
    rm -f /lib/systemd/system/sockets.target.wants/*udev* && \
    rm -f /lib/systemd/system/multi-user.target.wants/* && \
    rm -f /lib/systemd/system/local-fs.target.wants/* && \
    rm -f /lib/systemd/system/basic.target.wants/* && \
    rm -f /lib/systemd/system/systemd-update-utmp* ** \
    rm -f /etc/systemd/system/*.wants/*

# setup environment
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    echo "emileet ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    useradd -m -G wheel -s /usr/bin/zsh emileet && \
    chsh -s /usr/bin/zsh

ENV LANG=en_US.UTF-8
ENV container=docker
VOLUME ["/sys/fs/cgroup", "/run"]
CMD  ["/usr/lib/systemd/systemd"]
