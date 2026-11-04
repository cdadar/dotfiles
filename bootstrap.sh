#!/usr/bin/env bash
# bootstrap.sh — 新机器把本仓库的配置部署到当前用户的 $HOME（幂等，可重复跑）
#
# 用法：
#   git clone git@github.com:cdadar/dotfiles.git ~/project/private/dotfiles
#   cd ~/project/private/dotfiles && ./bootstrap.sh
#   ./bootstrap.sh --dry-run     # 只打印将执行的动作，不改任何文件
#   ./bootstrap.sh --no-brew     # 跳过 Homebrew（不装 brew、不跑 brew bundle）
#
# 做的事：
#   1. 装 git / curl / stow（缺则走系统包管理器），macOS 缺 Homebrew 先装 brew
#   2. 按 README.org「包清单与部署命令」把各 stow 包链接到 $HOME 与 ~/.config/*
#   3. 缺失的 ~/.zshenv.local / ~/.zshrc.local / ~/.bashrc.local / ~/.vimrc.local
#      从仓库对应 .example 模板复制（已存在则不动）
#   4. macOS 跑 brew bundle --global（读 $HOME/.Brewfile）
#   5. 校验关键文件仍是软链（防止被编辑器写穿），打印后续手工步骤
#
# 不管的（各自仓库 / 备份负责）：~/.emacs.d、~/project/private/script、
# ~/.pi/agent（bak_pi.sh 恢复）、~/.ssh。
set -uo pipefail

REPO_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
DRY_RUN=0
DO_BREW=1

say() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
ok() { printf '\033[1;32m  ✓\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m  !\033[0m %s\n' "$*"; }
die() {
    printf '\033[1;31m  ✗ %s\033[0m\n' "$*" >&2
    exit 1
}
# 只有 run 包住的动作会被 --dry-run 拦下
run() {
    if ((DRY_RUN)); then
        printf '  [dry-run] %s\n' "$*"
    else
        "$@"
    fi
}

usage() {
    cat <<'EOF'
用法：bootstrap.sh [--dry-run|-n] [--no-brew]

  (无参数)      装依赖 + stow 全部包 + 生成 .local + brew bundle + 校验软链
  --dry-run, -n 只打印将执行的动作，不改任何文件（新机器建议先跑一次）
  --no-brew     跳过 Homebrew：不装 brew、不跑 brew bundle
EOF
    exit 0
}

while (($#)); do
    case $1 in
    --dry-run | -n) DRY_RUN=1 ;;
    --no-brew) DO_BREW=0 ;;
    -h | --help) usage ;;
    *) die "未知参数：$1（-h 看用法）" ;;
    esac
    shift
done

# ---------------------------------------------------------------- 平台与依赖

case "$(uname -s)" in
Darwin) OS=macos ;;
Linux) OS=linux ;;
*) die "只支持 macOS / Linux，当前：$(uname -s)" ;;
esac

pkg_install() { # $@: 包名（brew/apt/dnf/pacman/zypper 同名）
    if ((DRY_RUN)); then
        printf '  [dry-run] 安装软件包：%s\n' "$*"
    elif command -v brew >/dev/null; then
        brew install "$@"
    elif command -v apt-get >/dev/null; then
        sudo apt-get update -qq && sudo apt-get install -y "$@"
    elif command -v dnf >/dev/null; then
        sudo dnf install -y "$@"
    elif command -v pacman >/dev/null; then
        sudo pacman -Sy --noconfirm "$@"
    elif command -v zypper >/dev/null; then
        sudo zypper --non-interactive install "$@"
    else
        return 1
    fi
}

ensure_tool() { # $1=命令名，其余=包管理器包名
    local cmd=$1
    shift
    if command -v "$cmd" >/dev/null; then
        ok "$cmd: $(command -v "$cmd")"
        return 0
    fi
    if ((DRY_RUN)); then
        warn "$cmd 缺失 —— [dry-run] 将安装 $*"
        return 0
    fi
    say "安装 $cmd"
    pkg_install "$@" || die "找不到可用的包管理器，装不了 $cmd"
    command -v "$cmd" >/dev/null || die "$cmd 装完仍不在 PATH，检查包管理器输出"
}

ensure_brew() {
    if command -v brew >/dev/null; then
        ok "Homebrew: $(brew --prefix)"
        return 0
    fi
    if ((DRY_RUN)); then
        warn "Homebrew 缺失 —— [dry-run] 将用官方脚本安装"
        return 0
    fi
    say "安装 Homebrew（官方脚本，可能要求输密码）"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" ||
        die "Homebrew 安装失败"
    local p
    for p in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
        if [ -x "$p" ]; then
            eval "$("$p" shellenv)"
            break
        fi
    done
    command -v brew >/dev/null || die "Homebrew 装完仍不在 PATH，新开一个 shell 重跑本脚本"
}

say "部署 dotfiles → ${HOME}（仓库：${REPO_DIR}）"
((DRY_RUN)) && warn "dry-run 模式：只打印，不改文件"

if [ "$OS" = macos ]; then
    ((DO_BREW)) && ensure_brew
    ((DO_BREW)) || warn "--no-brew：跳过 Homebrew"
fi
ensure_tool git git
ensure_tool curl curl
ensure_tool stow stow

# ---------------------------------------------------------------- stow 包部署
# 与 README.org「包清单与部署命令」一一对应；-t 的目标目录 stow 不会自己建，先 mkdir

STOW_FAILED=""
EXIT_CODE=0

stow_pkg() { # $1=target 目录，其余=stow 参数（末尾是包名）
    local target=$1 out
    shift
    if ((DRY_RUN)); then
        printf '  [dry-run] mkdir -p %s && stow -t %s %s\n' "$target" "$target" "$*"
        return 0
    fi
    mkdir -p "$target" || {
        warn "$target 建不了"
        STOW_FAILED="$STOW_FAILED $*"
        EXIT_CODE=1
        return 1
    }
    if out=$(cd "$REPO_DIR" && stow -t "$target" "$@" 2>&1); then
        ok "stow $* → $target"
    else
        warn "stow $* 失败（stow 不覆盖已存在的普通文件，见下）"
        printf '%s\n' "$out" | sed 's/^/      /'
        STOW_FAILED="$STOW_FAILED $*"
        EXIT_CODE=1
        return 1
    fi
}

# 包清单：改这里要同步改 README.org 的部署命令
PACKAGES_COMMON="bash zsh git tmux nodejs ctags tar aria2 mail sbcl pip mpv ghostty alacritty"
PACKAGES_LINUX_BASE="Xresources X11 wayland"
PACKAGES_LINUX_DESKTOP="xmonad i3 awesome rofi"
PACKAGES_LINUX_CONFIG="hypr mpd ranger sway" # 目标是 ~/.config/<包名>

ALL_PKGS="$PACKAGES_COMMON vim ideavimrc brew $PACKAGES_LINUX_BASE $PACKAGES_LINUX_DESKTOP $PACKAGES_LINUX_CONFIG"
for p in $ALL_PKGS; do
    [ -d "$REPO_DIR/$p" ] || die "包目录缺失：${p}（仓库不完整？）"
done

say "链接通用配置"
for p in $PACKAGES_COMMON; do
    stow_pkg "$HOME" --ignore='\.example$' "$p"
done

stow_pkg "$HOME" --ignore='^[^\.]+\..*vim.*' --ignore='\.example$' vim
stow_pkg "$HOME" --ignore='_ideavimrc' --ignore='idea_actionlist' ideavimrc
stow_pkg "$HOME" brew

if [ "$OS" = linux ]; then
    say "链接 Linux 桌面配置"
    for p in $PACKAGES_LINUX_BASE $PACKAGES_LINUX_DESKTOP; do
        stow_pkg "$HOME" --ignore='\.example$' "$p"
    done
    for p in $PACKAGES_LINUX_CONFIG; do
        stow_pkg "$HOME/.config/$p" "$p"
    done
else
    warn "macOS：跳过 Linux 桌面包（Xresources X11 wayland xmonad i3 awesome rofi hypr mpd ranger sway）"
fi

# ---------------------------------------------------------------- .local 模板
# 机器差异只进本机 .local（见 docs/machine-local.md），模板进仓库

seed_local() { # $1=仓库内模板（相对路径） $2=本机落点
    local src="$REPO_DIR/$1" dst=$2
    if [ ! -f "$src" ]; then
        warn "模板缺失：$1"
        return 1
    fi
    if [ -L "$dst" ]; then
        if [ -e "$dst" ]; then
            ok "$dst 是软链，保留不动"
        else
            warn "$dst 是死链（指向的仓库文件不存在）：确认后 rm 掉再重跑本脚本"
        fi
        return 0
    fi
    if [ -e "$dst" ]; then
        ok "$dst 已存在，保留不动"
        return 0
    fi
    if run cp "$src" "$dst"; then
        ok "新建 $dst ← $1"
    else
        warn "复制失败：$1 → $dst"
    fi
}

say "准备机器差异文件（.local）"
seed_local zsh/.zshenv.local.example "$HOME/.zshenv.local"
seed_local zsh/.zshrc.local.example "$HOME/.zshrc.local"
seed_local bash/.bashrc.local.example "$HOME/.bashrc.local"
seed_local vim/.vimrc.local.example "$HOME/.vimrc.local"

# ---------------------------------------------------------------- brew bundle

if [ "$OS" = macos ] && ((DO_BREW)) && command -v brew >/dev/null; then
    if [ -f "$HOME/.Brewfile" ]; then
        say "brew bundle --global（读 $HOME/.Brewfile）"
        run brew bundle --global || {
            warn "brew bundle 有失败项，看上面输出"
            EXIT_CODE=1
        }
    else
        warn "$HOME/.Brewfile 不存在（brew 包没 stow 上？），跳过 brew bundle"
    fi
fi

# ---------------------------------------------------------------- 校验与收尾

verify_links() {
    local f bad=0
    for f in .zshrc .zshenv .zprofile .gitconfig .tmux.conf .vimrc; do
        if [ -L "$HOME/$f" ]; then
            ok "$f → $(readlink "$HOME/$f")"
        elif [ -e "$HOME/$f" ]; then
            warn "$f 不是软链（被写成了普通文件），仓库改动不会生效"
            bad=1
        else
            warn "$f 不存在"
            bad=1
        fi
    done
    return $bad
}

if ((DRY_RUN)); then
    warn "dry-run：跳过软链校验"
else
    say "校验关键软链"
    verify_links || {
        warn "有文件不是软链：确认内容已进仓库后 rm 掉，再重跑本脚本"
        EXIT_CODE=1
    }
fi

echo
if [ -n "$STOW_FAILED" ]; then
    warn "以下包 stow 失败：$STOW_FAILED"
    warn "多半是本机已有同名普通文件。处理：把该文件内容并入仓库版本，"
    warn "或先挪开（mv ~/.xxx ~/.xxx.before-dotfiles）后重跑本脚本。"
    warn "不要手动往 $HOME 写文件 —— 那会是普通文件而不是软链。"
    echo
fi

cat <<'EOF'
后续手工步骤（脚本不代劳）：
  1. 重开 shell：exec zsh
     首次启动会自动 clone zinit，并按 _bootstrap_tools / gh-r 兜底补齐缺的工具。
  2. 填机器差异：~/.zshenv.local（SDK 路径、DOTFILES）、~/.zshrc.local（别名、代理、
     ssh-add）、~/.gitconfig.work 与 ~/.gitconfig.personal（git 身份，includeIf 已在
     master 的 ~/.gitconfig 里）。模板见 docs/machine-local.md。
  3. tmux：进 tmux 按 prefix + I 装插件（tpm 不存在时会自动 clone）。
  4. vim：首次启动自动装 vim-plug 并执行 PlugInstall。
  5. 仓库外的东西另装：~/.emacs.d（purcell fork）、~/project/private/script、
     ~/.pi/agent（用 script/personal/bak_pi.sh 的备份恢复，含 auth/secrets）、~/.ssh。
EOF

exit $EXIT_CODE
