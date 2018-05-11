# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
PS1="\[\033[0;35m\]-=(\u@\h)=- \[\033[0;32m\][\d \t]\n\w $\[\033[0m\] "

export EDITOR=/usr/bin/vim

alias ll='ls -la --color=auto'
