FROM archlinux/base:latest
MAINTAINER Emily Maré (emileet) <emileet@plsnobully.me>

# variables
ARG username=emileet

# install useful packages
RUN pacman -Syu --noconfirm && \
    pacman -S base-devel devtools nano sudo zsh --noconfirm && \
    pacman -Scc --noconfirm

# setup environment
RUN echo "$username ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    useradd -m -G wheel -s /bin/zsh $username && \
    chsh -s /bin/zsh && \
    touch /etc/localtime

# fix systemd
RUN rm -f /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* && \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl* && \
    rm -f /lib/systemd/system/sockets.target.wants/*udev* && \
    rm -f /lib/systemd/system/multi-user.target.wants/* && \
    rm -f /lib/systemd/system/local-fs.target.wants/* && \
    rm -f /lib/systemd/system/basic.target.wants/* && \
    rm -f /lib/systemd/system/systemd-update-utmp* && \
    rm -f /etc/systemd/system/*.wants/*

# install oh-my-zsh
RUN sudo -u $username sh -c 'yes | bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"' && \
    chown -R root:root /home/$username/.oh-my-zsh && \
    ln -s /home/$username/.zshrc /root/.zshrc

# install yay
RUN git clone https://aur.archlinux.org/yay.git && \
    chown -R $username:$username yay && cd yay && \
    sudo -u $username makepkg -cfirs --noconfirm && \
    cd .. && rm -rf yay

# copy over files
COPY .zshrc /home/$username

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd"]
