# =====================================================================
#  ~/.bashrc —— bash 环境总入口（PATH / 工具链 / 别名）
#  login shell 由 .bash_profile source，POSIX sh login 由 .profile source
#  只用 POSIX 语法；幂等，重复 source 不会重复 PATH
# =====================================================================

# ---------------------------- PATH ----------------------------
# 唯一来源：优先级从高到低，与 zsh/.zprofile 的 path 数组保持一致
# (opencode / local / volta / rbenv / go / android / JetBrains / homebrew / 系统)
_dotfiles_path="$HOME/.opencode/bin\
:$HOME/.local/bin\
:$HOME/.volta/bin\
:$HOME/.rbenv/shims\
:$HOME/.rbenv/bin\
:$HOME/.go/bin\
:$HOME/Library/go/sdk/go1.25.9/bin\
:$HOME/Library/go/sdk/go1.15.15/bin\
:$HOME/Library/Android/sdk/platform-tools\
:$HOME/Library/Android/sdk/emulator\
:$HOME/Library/Android/sdk/tools\
:$HOME/Library/Android/sdk/tools/bin\
:$HOME/Library/Android/sdk/cmdline-tools/latest/bin\
:$HOME/Library/Application Support/JetBrains/Toolbox/scripts\
:/opt/homebrew/bin\
:/opt/homebrew/sbin\
:/usr/local/opt/postgresql@15/bin\
:/Library/PostgreSQL/15/bin\
:/usr/local/opt/ruby/bin\
:/usr/local/bin\
:/usr/bin\
:/bin\
:/usr/sbin\
:/sbin"

PATH="$_dotfiles_path:$PATH"

# 去重 + 剔除不存在的目录，保留首次出现（= 上面的优先级生效）
case "$-" in *f*) _globoff= ;; *) set -f; _globoff=1 ;; esac
_ifs=$IFS
IFS=:
_new_path=
for _d in $PATH; do
    [ -n "$_d" ] && [ -d "$_d" ] || continue
    case ":$_new_path:" in
        *":$_d:"*) ;;
        *) _new_path="${_new_path:+$_new_path:}$_d" ;;
    esac
done
IFS=$_ifs
[ -n "$_globoff" ] && set +f
PATH=$_new_path
unset _dotfiles_path _new_path _ifs _globoff _d
export PATH

# ---------------------------- Volta (Node) ----------------------------
# shim 目录 $VOLTA_HOME/bin 已在上面 PATH 中且优先于 /usr/local/bin 的 brew node，
# 否则 node/npm/npx 会绕过 volta；VOLTA_HOME 是 shim 定位镜像的必需变量
export VOLTA_HOME="$HOME/.volta"

# ---------------------------- Go ----------------------------
export GOPATH="$HOME/.go"
export GO111MODULE=on
export GOPROXY=https://goproxy.cn,direct

# ---------------------------- Android ----------------------------
export ANDROID_HOME="$HOME/Library/Android/sdk"

# ---------------------------- Rust ----------------------------
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# ---------------------------- 编辑器 / 终端 ----------------------------
export ALTERNATE_EDITOR=vim EDITOR=vim VISUAL=vim
export STEAM_RUNTIME_PREFER_HOST_LIBRARIES=0

# ---------------------------- locale ----------------------------
case "$(tty 2>/dev/null)" in
    /dev/tty*) export LC_ALL=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LANG=en_US.UTF-8 ;;
    *)         export LC_ALL=zh_CN.UTF-8 LANGUAGE=zh_CN.UTF-8 LANG=zh_CN.UTF-8 ;;
esac

# ---------------------------- ssh ----------------------------
export SSH_KEY_PATH="$HOME/.ssh"

# ---------------------------- 交互式 shell 专属 ----------------------------
case "$-" in
*i*)
    alias sudo="sudo "
    alias em='emacsclient -t -a ""'   # 终端中开 emacs
    alias emc='emacsclient -nc -a ""' # emacs 图形界面
    alias wm_test='Xephyr :5 & sleep 1 ; DISPLAY=:5 awesome'

    ssh-add "$SSH_KEY_PATH/work_rsa" 2>/dev/null
    ;;
esac

# ---------------------------- SDKMAN ----------------------------
export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && . "$SDKMAN_DIR/bin/sdkman-init.sh"

# ---------------------------- 本机差异（必须放最后） ----------------------------
# 机器特定配置只进 ~/.bashrc.local（不进 git），模板见 bash/.bashrc.local.example
if [ -f "$HOME/.bashrc.local" ]; then
    . "$HOME/.bashrc.local"
fi
