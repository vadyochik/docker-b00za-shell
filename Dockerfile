FROM fedora
LABEL maintainer="b00za@pm.me"

# update the system and install general packages
# commenting out "tsflags=nodocs" as me needs man pages!!
RUN sed -i 's/^\s*tsflags=nodocs/#&/' /etc/dnf/dnf.conf && \
    dnf -y upgrade && \
    dnf -y groupinstall "Core" && \
    dnf -y groupinstall "Standard" && \
    dnf clean all

# installing additional packages
RUN dnf -y install mutt mailx isync abook fortune-mod \
#                   notmuch notmuch-mutt notmuch-vim \
                   cadaver libtranslate \
                   w3m ncftp whatmask iperf mc pinentry \
                   git sshrc tmuxinator vim-syntastic-ansible \
                   calcurse task tasksh vit timew kpcli \
                   pass pwgen apg && \
    dnf clean all

# add non-privileged user and configure sudo
RUN useradd -u 1001 -c "B00ZA U53R" -G wheel b00za && \
    sed -i 's/^%wheel\s*ALL=(ALL)\s*ALL$/# &/; s/^#\s*\(%wheel\s*ALL=(ALL)\s*NOPASSWD:\s*ALL$\)/\1/' /etc/sudoers

# copy our dotfiles
COPY ./dotfiles/ /home/b00za/
COPY ./examples/ /home/b00za/examples/

RUN chown -R b00za:b00za /home/b00za

USER b00za

WORKDIR /home/b00za

CMD ["tmuxinator", "start", "b00za"]
