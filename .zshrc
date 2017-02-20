# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git z d zsh-autosuggestions web-search wd)
plugins=(git z d zsh-autosuggestions web-search wd)
# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# ZSH_THEME="agnoster"

# java

#export JAVA_HOME=/usr/java/jdk1.6.0_45
#export JRE_HOME=/usr/java/jdk1.6.0_45/jre
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

# steam no runtime
export STEAM_RUNTIME=1

#export http_proxy="http://localhost:8118"
#export https_proxy="http://localhost:8118"


source $ZSH/oh-my-zsh.sh


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="$HOME/.ssh"
ssh-add "$SSH_KEY_PATH/work_rsa"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#终端配色
export TERM=xterm-256color

export MALLOC_CHECK_=1

tmux_init()
{
    tmux new-session -s "chen" -d -n "local"    # 开启一个会话
    tmux attach
}

# 判断是否已有开启的tmux会话，没有则开启
if which tmux 2>&1 >/dev/null; then
    test -z "$TMUX" && (tmux attach || tmux_init)
fi



alias sudo="sudo "

alias em='emacsclient -t -a ""'  #在终端中开启emacs
alias emc='emacsclient -nc -a ""'  #启动emacs图形界面
EDITOR='emacsclient -a ""'
