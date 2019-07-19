# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias sudo="sudo "

#export ALTERNATE_EDITOR=emacs EDITOR=emacsclient VISUAL=emacsclient
export ALTERNATE_EDITOR=vim EDITOR=vim VISUAL=vim


alias em='emacsclient -t -a ""'  #在终端中开启emacs
alias emc='emacsclient -nc -a ""'  #启动emacs图形界面

alias wm_test='Xephyr :5 & sleep 1 ; DISPLAY=:5 awesome'

# steam no runtime
# export STEAM_RUNTIME=1

export STEAM_RUNTIME_PREFER_HOST_LIBRARIES=0

# 终端颜色
export TERM=xterm-256color

# 错误检查
export MALLOC_CHECK_=1

# load xterm config
# xrdb $HOME/.Xresources


# export HTTP_PROXY_REQUEST_FULLURI=0
# export HTTPS_PROXY_REQUEST_FULLURI=0

# export HTTP_PROXY=http://127.0.0.1:8118

# export LANG=zh_CN.UTF-8



