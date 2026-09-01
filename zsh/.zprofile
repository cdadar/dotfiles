# ========================
# 基础环境
# ========================

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ========================
# PATH 管理（核心优化）
# ========================

# 使用 zsh 数组避免重复
typeset -U path PATH

# 手动定义优先级（从高到低）
path=(
  $HOME/.opencode/bin
  $HOME/.local/bin
  $HOME/.volta/bin
  $HOME/.rbenv/shims
  $HOME/.rbenv/bin
  $HOME/.go/bin
  $HOME/Library/go/sdk/go1.25.9/bin
  $HOME/Library/go/sdk/go1.15.15/bin

  /usr/local/opt/postgresql@15/bin
  /Library/PostgreSQL/15/bin
  /usr/local/opt/ruby/bin

  /usr/local/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin

  $path
)

export PATH

# ========================
# Volta (Node)
# ========================

export VOLTA_HOME="$HOME/.volta"

# ========================
# rbenv
# ========================

eval "$(rbenv init -)"

# ========================
# Go
# ========================

export GOPATH="$HOME/.go"
export GO111MODULE=on
export GOPROXY=https://goproxy.cn,direct

# ========================
# Android
# ========================

export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/tools/bin"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"

# ========================
# JetBrains Toolbox
# ========================

export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"

# ========================
# SDKMAN
# ========================

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# ========================
# SSH
# ========================

export SSH_KEY_PATH="$HOME/.ssh"
ssh-add "$SSH_KEY_PATH/work_rsa" 2>/dev/null

# ========================
# 编辑器
# ========================

export EDITOR=vim
export VISUAL=vim
export ALTERNATE_EDITOR=vim

# ========================
# alias
# ========================

alias sudo="sudo "
alias em='emacsclient -t -a ""'
alias emc='emacsclient -nc -a ""'

# Apple Silicon brew（跨机器保留）
export PATH="/opt/homebrew/sbin:$PATH"

# Hermes Agent — ensure ~/.local/bin is on PATH
export PATH="$HOME/.local/bin:$PATH"

# Pi
export PATH="/Users/chens/.volta/bin:$PATH"
