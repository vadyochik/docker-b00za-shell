FROM fedora

# me needs man pages!!
RUN sed -i 's/^\s*tsflags=nodocs/#&/' /etc/dnf/dnf.conf

# install groups of packages
RUN dnf -y upgrade && \
    dnf -y groupinstall "Core" && \
    dnf -y groupinstall "Standard" && \
    dnf -y install abook alpine cadaver \
                   deletemail elinks fetchmail \
                   getmail iperf isync lftp libtranslate \
                   lynx mutt ncftp w3m whatmask && \
    dnf -y groupinstall "Text-based Internet" && \
    dnf -y install sshrc tmux mc vim-syntastic-ansible \
                   calcurse task tasksh vit timew kpcli \
                   pwgen apg && \
    dnf clean all

# add non-privileged user and configure sudo
RUN useradd -u 1001 -c "B00ZA U53R" -G wheel b00za && \
    sed -i 's/^%wheel\s*ALL=(ALL)\s*ALL$/# &/; s/^#\s*\(%wheel\s*ALL=(ALL)\s*NOPASSWD:\s*ALL$\)/\1/' /etc/sudoers

# copy our dotfiles
COPY ./dotfiles/* /home/b00za/

RUN chown -R b00za:b00za /home/b00za

USER b00za

WORKDIR /home/b00za

CMD ["tmux", "-u"]
