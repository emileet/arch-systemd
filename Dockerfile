FROM archlinux/base:latest
MAINTAINER Emily Maré (emileet) <emileet@plsnobully.me>

RUN \
  # first, update everything
  pacman -Syyu --noconfirm --noprogressbar --quiet && \
  # install useful packages
  pacman -S awk base-devel cockpit git nano packagekit rxvt-unicode sudo zsh --noconfirm --noprogressbar --quiet && \
  # now lets cleanup
  pacman -Scc --noconfirm --noprogressbar --quiet && \
  # fix systemd
  (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done) && \
  rm -f /lib/systemd/system/multi-user.target.wants/* && \
  rm -f /etc/systemd/system/*.wants/* && \
  rm -f /lib/systemd/system/local-fs.target.wants/* && \
  rm -f /lib/systemd/system/sockets.target.wants/*udev* && \
  rm -f /lib/systemd/system/sockets.target.wants/*initctl* && \
  rm -f /lib/systemd/system/basic.target.wants/* && \
  rm -f /lib/systemd/system/anaconda.target.wants/* && \
  # install ohmyzsh
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
  # create user account
  echo "emileet ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
  useradd -m -G root -s /usr/bin/zsh emileet && \
  cp ~/.zshrc /home/emileet/.zshrc && \
  # set user passwd
  echo "emileet:emileet" | chpasswd && \
  # set root passwd
  echo "root:emileet" | chpasswd && \
  # set shell
  chsh -s /usr/bin/zsh

EXPOSE 9090
ENV LANG=en_US.UTF-8
ENV container=docker
VOLUME ["/sys/fs/cgroup", "/run", "/setup"]
CMD  ["/usr/lib/systemd/systemd"]
