# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && source $HOME/.bashrc


# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias sudo="sudo "

#export ALTERNATE_EDITOR=emacs EDITOR=emacsclient VISUAL=emacsclient
export ALTERNATE_EDITOR=vim EDITOR=vim VISUAL=vim


alias em='emacsclient -t -a ""'  #在终端中开启emacs
alias emc='emacsclient -nc -a ""'  #启动emacs图形界面

alias wm_test='Xephyr :5 & sleep 1 ; DISPLAY=:5 awesome'

alias gf='~/.go/bin/gf '

# steam no runtime
# export STEAM_RUNTIME=1

export STEAM_RUNTIME_PREFER_HOST_LIBRARIES=0

#ssh
# SSH_ENV="$HOME/.ssh/environment"

# function start_agent {
#     echo "Initialising new SSH agent..."
#     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
#     echo succeeded
#     chmod 600 "${SSH_ENV}"
#     . "${SSH_ENV}" > /dev/null
#     /usr/bin/ssh-add;
# }

# # Source SSH settings, if applicable

# if [ -f "${SSH_ENV}" ]; then
#     . "${SSH_ENV}" > /dev/null
#     #ps ${SSH_AGENT_PID} doesn't work under cywgin
#     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
#         start_agent;
#     }
# else
#     start_agent;
# fi



# 终端颜色
# export TERM=xterm-256color

# 错误检查
export MALLOC_CHECK_=1

# export HTTP_PROXY_REQUEST_FULLURI=0
# export HTTPS_PROXY_REQUEST_FULLURI=0

# export HTTP_PROXY=http://127.0.0.1:8118
# export HTTPS_PROXY=https://127.0.0.1:8118

# export LANG=zh_CN.UTF-8

# load xterm config
# xrdb $HOME/.Xresources
# [[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources

# ssh
export SSH_KEY_PATH="$HOME/.ssh"
ssh-add "$SSH_KEY_PATH/work_rsa"
# unset SSH_ASKPASS


# locale
# if [[ $(tty) == /dev/tty* ]]; then
#     export LC_ALL="en_US.UTF-8"
#     export LANGUAGE="en_US.UTF-8"
#     export LANG="en_US.UTF-8"
# else
#     export LC_ALL="zh_CN.UTF-8"
#     export LANGUAGE="zh_CN.UTF-8"
#     export LANG="zh_CN.UTF-8"
# fi


# export LC_ALL="en_US.UTF-8"
# export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
