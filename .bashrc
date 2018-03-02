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


# java
export JAVA_HOME=~/program/jdk1.8.0_73/
export JRE_HOME=~/program/jdk1.8.0_73/jre
#export JAVA_HOME=~/program/jdk1.7.0_79
#export JRE_HOME=~/program/jdk1.7.0_79jre
export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
export CLASSPATH=$CLASSPATH:.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib

# ant
export ANT_HOME=~/source/ant/bootstrap
export PATH=$PATH:$ANT_HOME/bin

# mevan
export MAVEN_HOME=~/program/maven
export M2_HOME=~/program/maven
export  PATH=$PATH:$MAVEN_HOME/bin

# activeMQ
export ACTIVEMQ_HOME=~/program/apache-activemq
export PATH=$PATH:$ACTIVEMQ_HOME/bin


# gradle
GRADLE_HOME=~/program/gradle
export PATH=$PATH:$GRADLE_HOME/bin

#lwqq
#export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

# node
export NODE_HOME=/usr/local
export PATH=$PATH:$NODE_HOME/bin
export NODE_PATH=$NODE_HOME/lib/node_modules

# Android_SDK
export ANDROID_SDK=~/program/android-sdk-linux

# Android ndk
export ANDROID_NDK_HOME=~/program/android-ndk
export PATH=$ANDROID_SDK/platform-tools:$ANDROID_SDK/tools:$PATH:$ANDROID_NDK_HOME

# grails
export GRAILS_HOME=~/program/grails
export PATH=$GRAILS_HOME/bin:$PATH

#cabel Haskell package manager
export PATH=$HOME/.cabal/bin:$PATH

#lisp roswell
export PATH=$HOME/.roswell/bin:$PATH


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
source /usr/bin/virtualenvwrapper.sh

# yarn
export PATH="$PATH:`yarn global bin`:$HOME/.config/yarn/global/node_modules/.bin"

# php composer
export PATH=$PATH:$HOME/.config/composer/vendor/bin

#ssh 
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# ssh
export SSH_KEY_PATH="$HOME/.ssh"
ssh-add "$SSH_KEY_PATH/work_rsa"

export SSH_ASKPASS=/usr/lib/ssh/ssh-askpass

# steam no runtime
# export STEAM_RUNTIME=1

export STEAM_RUNTIME_PREFER_HOST_LIBRARIES=0

# 终端颜色
export TERM=xterm-256color

# 错误检查
export MALLOC_CHECK_=1



# export HTTP_PROXY_REQUEST_FULLURI=0
# export HTTPS_PROXY_REQUEST_FULLURI=0

# export HTTP_PROXY=http://127.0.0.1:8118

# export LANG=zh_CN.UTF-8
