# shellcheck disable=SC1087,SC1090,SC1091,SC2015,SC2016,SC2086,SC2125,SC2128,SC2139,SC2148,SC2154,SC2206,SC2296
# 本文件是 zsh，ShellCheck 只认 sh/bash，说明见 zsh/.zshrc 顶部

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
  $HOME/.local/bin            # Antigravity CLI
  $HOME/.volta/bin            # volta (Node) / Pi
  $HOME/.rbenv/shims
  $HOME/.rbenv/bin
  $HOME/.go/bin

  /opt/homebrew/bin            # Apple Silicon brew（x86 上不存在，会被下面过滤掉）
  /opt/homebrew/sbin
  /Library/PostgreSQL/15/bin
  /usr/local/opt/ruby/bin

  /usr/local/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin

  # 本机专有路径（go sdk 版本、Android SDK、JetBrains 等）见 ~/.zshrc.local
  $path
)

# 剔除不存在的目录（保持顺序；zsh 的 -U 只去重不检查存在性）
_paths=()
for _d in $path; do
  [[ -d $_d ]] && _paths+=("$_d")
done
path=($_paths)
unset _paths _d

export PATH

# ========================
# Volta (Node)
# ========================

export VOLTA_HOME="$HOME/.volta"

# ========================
# rbenv
# ========================

if (( $+commands[rbenv] )); then
    eval "$(rbenv init -)"
fi

# ========================
# Go
# ========================

export GOPATH="$HOME/.go"
export GO111MODULE=on
export GOPROXY=https://goproxy.cn,direct

# ========================
# Android
# ========================

# Android SDK 路径属本机专有，见 ~/.zshrc.local；ANDROID_HOME 通用，保留
export ANDROID_HOME="$HOME/Library/Android/sdk"

# ========================
# SDKMAN
# ========================

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# ========================
# SSH
# ========================

# 具体 key 属本机专有（如 work_rsa），ssh-add 见 ~/.zshrc.local
export SSH_KEY_PATH="$HOME/.ssh"

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
