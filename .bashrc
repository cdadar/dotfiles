# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias sudo="sudo "


alias mysqlbak_remote="mysqldump -u root -h mysql.bmdcy.com -P 13306 -p "
#alias mysqlbak_wjk="mysqldump -u root  -h 121.43.116.222 -p "

alias em='emacsclient -t -a ""'  #在终端中开启emacs
alias emc='emacsclient -nc -a ""'  #启动emacs图形界面
EDITOR='emacsclient -a ""'

# java
export JAVA_HOME=/home/chen/program/jdk1.8.0_73/
export JRE_HOME=/home/chen/program/jdk1.8.0_73/jre
#export JAVA_HOME=/home/chen/program/jdk1.7.0_79
#export JRE_HOME=/home/chen/program/jdk1.7.0_79jre
export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
export CLASSPATH=$CLASSPATH:.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib

# ant
export ANT_HOME=/home/chen/source/ant/bootstrap
export PATH=$PATH:$ANT_HOME/bin

# mevan
export MAVEN_HOME=~/program/maven
export M2_HOME=~/program/maven
export  PATH=$PATH:$MAVEN_HOME/bin

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


#cabel Haskell package manager
export PATH=$HOME/.cabal/bin:$PATH

# ssh
export SSH_KEY_PATH="$HOME/.ssh"

ssh-add "$SSH_KEY_PATH/work_rsa"



# steam no runtime
export STEAM_RUNTIME=1

export TERM=xterm-256color


# ssh
export SSH_KEY_PATH="$HOME/.ssh"

ssh-add "$SSH_KEY_PATH/work_rsa"
