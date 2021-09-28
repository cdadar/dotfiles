# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin=$PATH:/usr/local/bin

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

# node
export NODE_HOME=/usr/local
export PATH=$PATH:$NODE_HOME/bin
export NODE_PATH=$NODE_HOME/lib/node_modules

# yarn
# export PATH="$PATH:`yarn global bin`:$HOME/.config/yarn/global/node_modules/.bin"

# Android_SDK
#export ANDROID_SDK=$HOME/program/android-sdk-linux

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
export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=$HOME/workspace
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
source /usr/bin/virtualenvwrapper


# php composer
export PATH=$PATH:$HOME/.config/composer/vendor/bin

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
# Enable the go modules feature
export GO111MODULE=on
# Set the GOPROXY environment variable
export GOPROXY=https://goproxy.io


# cask
# export PATH="$HOME/.cask/bin:$PATH"

# rust
export PATH="$HOME/.cargo/bin:$PATH"


# nix
# if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
#     # added by Nix installer
#     . $HOME/.nix-profile/etc/profile.d/nix.sh;
# fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="/home/chens/.sdkman"
# [[ -s "/home/chens/.sdkman/bin/sdkman-init.sh" ]] && source "/home/chens/.sdkman/bin/sdkman-init.sh"

export PATH=/snap/bin:$PATH

export WINEARCH=win32

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"


export TERM=xterm-color

if [[ $(tty) != /dev/tty* ]]; then
    [[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
fi
