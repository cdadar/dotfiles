[ -f $HOME/.bash_profile ] && source  $HOME/.bash_profile
# User specific environment and startup programs

#PATH="$PATH:$HOME/.local/bin:$HOME/bin"

#PATH="$PATH:/usr/local/bin"

# java
# export JAVA_HOME=$HOME/program/jdk1.8.0_73/
# export JRE_HOME=$HOME/program/jdk1.8.0_73/jre
# export JAVA_HOME=$HOME/program/jdk1.7.0_79
# export JRE_HOME=$HOME/program/jdk1.7.0_79jre
# export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
# export CLASSPATH=$CLASSPATH:.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib

# grails
#export GRAILS_HOME=$HOME/program/grails
#export PATH=$GRAILS_HOME/bin:$PATH

# ant
#export ANT_HOME=$HOME/source/ant/bootstrap
#export PATH=$PATH:$ANT_HOME/bin

# mevan
#export MAVEN_HOME=$HOME/program/maven
#export M2_HOME=$HOME/program/maven
#export  PATH=$PATH:$MAVEN_HOME/bin
#
# activeMQ
#export ACTIVEMQ_HOME=$HOME/program/apache-activemq
#export PATH=$PATH:$ACTIVEMQ_HOME/bin


# gradle
#GRADLE_HOME=$HOME/program/gradle
#export PATH=$PATH:$GRADLE_HOME/bin

#lwqq
#export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# node
export NODE_HOME=/usr/local
export PATH=$PATH:$NODE_HOME/bin
export NODE_PATH=$NODE_HOME/lib/node_modules

# yarn
# export PATH="$PATH:`yarn global bin`:$HOME/.config/yarn/global/node_modules/.bin"

# Android_SDK
export ANDROID_NAME=$HOME/program/android-sdk
export PATH=$PATH:$ANDROID_NAME/platform-tools
export PATH=$PATH:$ANDROID_NAME/emulator
export PATH=$PATH:$ANDROID_NAME/tools
export PATH=$PATH:$ANDROID_NAME/tools/bin


# Android ndk
#export ANDROID_NDK_HOME=$HOME/program/android-ndk
#export PATH=$ANDROID_SDK/platform-tools:$ANDROID_SDK/tools:$PATH:$ANDROID_NDK_HOME


#cabel Haskell package manager
#export PATH=$HOME/.cabal/bin:$PATH

#lisp roswell
#export PATH=$HOME/.roswell/bin:$PATH

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"

# add rbenv to path
export PATH=$HOME/.rbenv/bin:$PATH

eval "$(rbenv init -)"

export PATH=$HOME/.rbenv/plugins/ruby-build/bin:$HOME/.rbenv/shims/:$PATH

# python virtualenvwrapper
#export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=$HOME/workspace
#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
#export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv
#export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
#source /usr/bin/virtualenvwrapper


# php composer
export PATH=$PATH:$HOME/.config/composer/vendor/bin

# go
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
# Enable the go modules feature
export GO111MODULE=on
# Set the GOPROXY environment variable
# export GOPROXY=https://goproxy.io
# export GOPROXY=https://mirrors.aliyun.com/goproxy

# 配置 GOPROXY 环境变量
export GOPROXY=https://goproxy.cn,direct
# 还可以设置不走 proxy 的私有仓库或组，多个用逗号相隔（可选）
# export GOPRIVATE=git.mycompany.com,github.com/my/private


# cask
# export PATH="$HOME/.cask/bin:$PATH"

# rust
# export PATH="$HOME/.cargo/bin:$PATH"

# flutter
# export PATH="$PATH:$HOME/program/flutter/bin"


# nix
# if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
#     # added by Nix installer
#     . $HOME/.nix-profile/etc/profile.d/nix.sh;
# fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="/home/chens/.sdkman"
# [[ -s "/home/chens/.sdkman/bin/sdkman-init.sh" ]] && source "/home/chens/.sdkman/bin/sdkman-init.sh"

# export PATH=/snap/bin:$PATH

# export WINEARCH=win64
# export WINEPREFIX=~/.wine64
# export WINEARCH=win32
# export WINEPREFIX=~/.wine

# base16 Shell
# BASE16_SHELL="$HOME/.config/base16-shell/"
# [ -n "$PS1" ] && \
#     [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#         source "$BASE16_SHELL/profile_helper.sh"

# export TERM=xterm-color

# if [[ $(tty) != /dev/tty* ]]; then
#     [[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
# fi
# export VOLTA_HOME="$HOME/.volta"
# export PATH="$VOLTA_HOME/bin:$PATH"
# . "$HOME/.cargo/env"

# [ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"


# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias sudo="sudo "

#export ALTERNATE_EDITOR=emacs EDITOR=emacsclient VISUAL=emacsclient
export ALTERNATE_EDITOR=vim EDITOR=vim VISUAL=vim


alias em='emacsclient -t -a ""'  #在终端中开启emacs
alias emc='emacsclient -nc -a ""'  #启动emacs图形界面

alias wm_test='Xephyr :5 & sleep 1 ; DISPLAY=:5 awesome'

# unalias gf
# alias gf='~/.go/bin/gf '

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

# export HTTP_PROXY=http://127.0.0.1:7890
# export HTTPS_PROXY=https://127.0.0.1:7890

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
# export LANG="en_US.UTF-8"


export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# . "$HOME/.cargo/env"


# Added by Toolbox App
export PATH="$PATH:/Users/chens/Library/Application Support/JetBrains/Toolbox/scripts"

# Added by Toolbox App
export PATH="$PATH:/usr/local/bin"



export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$PATH:/usr/local/bin"

export PATH="/Library/PostgreSQL/15/bin:$PATH"
export PATH="/usr/local/opt/postgresql@15/bin:$PATH"
export PATH="/usr/local/opt/postgresql@15/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


eval "$(/opt/homebrew/bin/brew shellenv)"

