# shellcheck disable=SC1091,SC2148
# rc 文件被 .bash_profile / .profile source，不写 shebang；source 的对象路径运行期才决定

# =====================================================================
#  ~/.bashrc —— bash 环境总入口（PATH / 工具链 / 别名）
#  login shell 由 .bash_profile source，POSIX sh login 由 .profile source
#  只用 POSIX 语法；幂等，重复 source 不会重复 PATH
# =====================================================================

# ---------------------------- PATH ----------------------------
# 唯一来源：优先级从高到低，与 zsh/.zprofile 的 path 数组保持一致
# (opencode / local / volta / rbenv / go / homebrew / 系统)
# 本机专有路径（go sdk 版本、Android SDK 等）见 ~/.bashrc.local
_dotfiles_path="$HOME/.opencode/bin\
:$HOME/.local/bin\
:$HOME/.volta/bin\
:$HOME/.rbenv/shims\
:$HOME/.rbenv/bin\
:$HOME/.go/bin\
:/opt/homebrew/bin\
:/opt/homebrew/sbin\
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

# ---------------------------- Pi（coding agent） ----------------------------
# ask_user 用 inline 渲染（默认 overlay 弹窗会盖住上方输出）
export PI_ASK_USER_DISPLAY_MODE=inline

# ---------------------------- locale ----------------------------
# 与 zsh/.zprofile 保持一致（曾是按 tty 分中英文，两个 shell 行为不一致）
export LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# ---------------------------- ssh ----------------------------
export SSH_KEY_PATH="$HOME/.ssh"

# ---------------------------- 交互式 shell 专属 ----------------------------
case "$-" in
*i*)
    alias sudo="sudo "
    alias em='emacsclient -t -a ""'   # 终端中开 emacs
    alias emc='emacsclient -nc -a ""' # emacs 图形界面
    alias wm_test='Xephyr :5 & sleep 1 ; DISPLAY=:5 awesome'
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
