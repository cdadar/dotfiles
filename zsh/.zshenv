# shellcheck disable=SC1087,SC1090,SC1091,SC2015,SC2016,SC2086,SC2125,SC2128,SC2139,SC2148,SC2154,SC2206,SC2296
# 本文件是 zsh，ShellCheck 只认 sh/bash，说明见 zsh/.zshrc 顶部
#
# .zshenv 被**每一个** zsh 进程读取（login / 非 login、交互 / 非交互、脚本里的
# `zsh -c`）。所以这里只放「任何 zsh 进程跑命令都需要」的环境：PATH 和环境变量。
# 只对交互有意义的（alias）、要花时间 eval 的（rbenv/sdkman init）放 .zshrc / .zprofile。
# 本文件必须不产生任何标准输出。

# ========================
# 基础环境
# ========================

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ========================
# PATH（唯一顺序定义在 _dotfiles_path_head）
# ========================

# 使用 zsh 数组避免重复（-U 只去重，不检查存在性）
typeset -U path PATH

# 优先级从高到低。/usr/local/bin 的 brew node/go 必须排在 ~/.volta/bin 和
# go sdk 之后，否则 node/npm/npx 会绕过 volta。
typeset -ga _dotfiles_path_head=(
  $HOME/.opencode/bin
  $HOME/.local/bin            # Antigravity CLI
  $HOME/.local/share/zinit/polaris/bin   # zinit 装的东西（gh-r 兜底二进制）
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
)

# 按 _dotfiles_path_head 的顺序重排 PATH，并剔除不存在的目录（含继承来的）；
# 收尾是把继承来的路径全排在自定义顺序之后，/Library/TeX/texbin 这类不会丢。
_dotfiles_path_set() {
  local -a _keep=()
  local _p
  for _p in $_dotfiles_path_head $path; do
    [[ -d $_p ]] && _keep+=("$_p")
  done
  path=($_keep)
  export PATH
}

# 机器差异（本机 SDK 路径、工具环境变量）。
# 路径要压过 /usr/local/bin（如 go sdk vs brew go）就插到 _dotfiles_path_head 前面；
# 只是追加到末尾的直接 `export PATH="...:$PATH"`。
[[ -f $HOME/.zshenv.local ]] && source $HOME/.zshenv.local

_dotfiles_path_set

# 记住最终顺序（含 .zshenv.local 改过的优先级）：macOS 的 /etc/zprofile 会在
# .zshenv 之后跑 path_helper，把 /etc/paths(.d)（含 /usr/local/bin）前置，
# .zprofile 要用这个顺序把它压回去。
typeset -gx _dotfiles_path_canonical=$PATH

# 供 .zprofile 在 path_helper 之后调用：恢复上面的顺序，并把 path_helper 新增的
# 目录（/Library/TeX/texbin、Cryptexes 等）追加到末尾（存在才留）。
_dotfiles_path_restore() {
  local -a _ok=(${(s.:.)_dotfiles_path_canonical}) _new=()
  local _p
  for _p in ${path:|_ok}; do
    [[ -d $_p ]] && _new+=("$_p")
  done
  path=($_ok $_new)
  export PATH
}

# ========================
# Volta (Node)：shim 靠它定位 node 镜像，非交互 shell 也必须有
# ========================

export VOLTA_HOME="$HOME/.volta"

# ========================
# Go
# ========================

export GOPATH="$HOME/.go"
export GO111MODULE=on
export GOPROXY=https://goproxy.cn,direct

# ========================
# Android
# ========================

# Android SDK 路径属本机专有，见 ~/.zshenv.local；ANDROID_HOME 通用，保留
export ANDROID_HOME="$HOME/Library/Android/sdk"

# ========================
# Pi（coding agent）
# ========================

# ask_user 用 inline 渲染：默认的 overlay 弹窗会盖住上方输出，而选项往往要靠
# 这些输出才能定（overlay 下可按 alt+o 临时隐藏，见 pi-ask-user README）
export PI_ASK_USER_DISPLAY_MODE=inline

# ========================
# 编辑器 / SSH
# ========================

export EDITOR=vim
export VISUAL=vim
export ALTERNATE_EDITOR=vim

# 具体 key 属本机专有（如 work_rsa），ssh-add 见 ~/.zshrc.local
export SSH_KEY_PATH="$HOME/.ssh"
