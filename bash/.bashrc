# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


# User specific environment and startup programs

PATH="$PATH:$HOME/.local/bin:$HOME/bin"

PATH="$PATH:/usr/local/bin"

#jetbrains 
PATH="$PATH:$HOME/.local/share/Jetbrains/scripts"

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
export PATH="$HOME/.cargo/bin:$PATH"

# flutter
export PATH="$PATH:$HOME/program/flutter/bin"


# nix
# if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
#     # added by Nix installer
#     . $HOME/.nix-profile/etc/profile.d/nix.sh;
# fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="/home/chens/.sdkman"
# [[ -s "/home/chens/.sdkman/bin/sdkman-init.sh" ]] && source "/home/chens/.sdkman/bin/sdkman-init.sh"

export PATH=/snap/bin:$PATH

export WINEARCH=win64
export WINEPREFIX=~/.wine64
# export WINEARCH=win32
# export WINEPREFIX=~/.wine

# base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"

export TERM=xterm-color

# if [[ $(tty) != /dev/tty* ]]; then
#     [[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
# fi
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
. "$HOME/.cargo/env"

[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"
