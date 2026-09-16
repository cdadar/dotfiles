# shellcheck disable=SC1087,SC1090,SC1091,SC2015,SC2016,SC2086,SC2125,SC2128,SC2139,SC2148,SC2154,SC2206,SC2296
# 本文件是 zsh，ShellCheck 只认 sh/bash：以上均为 zsh 语法的误报（${(j: :)..}、$+commands[x]、
# fzf-tab 里故意延迟展开的 $word、rc 文件不该有 shebang 等）。只屏蔽具体检查项，
# 解析错误（SC1009/SC1036/SC1058/SC1072/SC1073）仍会报出。语法检查用 `zsh -n`。

# OPENSPEC:START
# OpenSpec shell completions configuration
fpath=("$HOME/.zsh/completions" $fpath)
# compinit 由下方 zinit 的 zicompinit 负责，这里不再重复初始化
# OPENSPEC:END

# copy https://github.com/seagle0128/dotfiles/blob/master/shell/.zshrc

# Zsh configuration



# vars（机器特定路径已移到 ~/.zshrc.local：DOTFILES/EMACSD）

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone --depth=1 https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
            print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode depth"1" for \
      zdharma-continuum/zinit-annex-bin-gem-node \
      zdharma-continuum/zinit-annex-patch-dl

### End of Zinit's installer chunk

# Oh My Zsh
zinit for \
      OMZL::correction.zsh \
      OMZL::directories.zsh \
      OMZL::history.zsh \
      OMZL::key-bindings.zsh \
      OMZL::theme-and-appearance.zsh \
      OMZP::common-aliases

zinit wait lucid for \
      OMZP::colored-man-pages \
      OMZP::cp \
      OMZP::extract \
      OMZP::fancy-ctrl-z \
      OMZP::git \
      OMZP::sudo

# Homebrew completion
if (( $+commands[brew] )); then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# 缺工具自动补齐（全新机器上首次开 shell 即装齐；已装则零成本跳过）
# 格式：命令:brew包:apt包:pacman包:zypper包
function _bootstrap_tools() {
    local -a spec=(
      rg:ripgrep:ripgrep:ripgrep:ripgrep
      fd:fd:fd-find:fd:fd
      fzf:fzf:fzf:fzf:fzf
      eza:eza:eza:eza:eza
      bat:bat:bat:bat:bat
      delta:git-delta:git-delta:git-delta:git-delta
      zoxide:zoxide:zoxide:zoxide:zoxide
      lazygit:lazygit:lazygit:lazygit:lazygit
      atuin:atuin:atuin:atuin:atuin
      tldr:tldr:tldr:tldr:tldr
      git-extras:git-extras:git-extras:git-extras:git-extras
    ) missing=() pkgs=() parts
    local s
    for s in $spec; do
        (( $+commands[${s%%:*}] )) || missing+=($s)
    done
    (( ${#missing} )) || return 0
    if [[ $OSTYPE == darwin* ]] && (( $+commands[brew] )); then
        for s in $missing; do parts=(${(s.:.)s}); pkgs+=($parts[2]); done
    elif (( $+commands[apt-get] )); then
        for s in $missing; do parts=(${(s.:.)s}); pkgs+=($parts[3]); done
    elif (( $+commands[pacman] )); then
        for s in $missing; do parts=(${(s.:.)s}); pkgs+=($parts[4]); done
    elif (( $+commands[zypper] )); then
        for s in $missing; do parts=(${(s.:.)s}); pkgs+=($parts[5]); done
    else
        print -P "%F{220}缺 ${(j: :)${(@)missing%%:*}}，无 brew/apt/pacman/zypper，交给下方 gh-r 兜底%f"
        return 0
    fi
    print -P "%F{33}→ %F{220}安装缺失工具：${(j: :)pkgs}%f"
    if [[ $OSTYPE == darwin* ]] && (( $+commands[brew] )); then
        brew install $pkgs
    elif (( $+commands[apt-get] )); then
        sudo apt-get install -y $pkgs
        (( $+commands[fdfind] )) && ! (( $+commands[fd] )) && alias fd=fdfind
    elif (( $+commands[pacman] )); then
        sudo pacman -S --noconfirm $pkgs
    elif (( $+commands[zypper] )); then
        sudo zypper install -y $pkgs
    fi
}
_bootstrap_tools
unset -f _bootstrap_tools

# gh-r 兜底：包管理器装不到的场合（Linux 上 apt 没这个包 / 无 root / 新机器还没装 brew）
# 直接从 GitHub Release 下二进制到 $ZPFX/bin（已在 PATH 中）；已装上则 if 守卫直接跳过
# tldr / git-extras 没有二进制 release，不做兜底，只靠包管理器
zinit ice as"program" from"gh-r" if'! (( $+commands[rg] ))' sbin'rg'
zinit light BurntSushi/ripgrep
zinit ice as"program" from"gh-r" if'! (( $+commands[fd] ))' sbin'fd'
zinit light sharkdp/fd
zinit ice as"program" from"gh-r" if'! (( $+commands[fzf] ))' sbin'fzf'
zinit light junegunn/fzf
zinit ice as"program" from"gh-r" if'! (( $+commands[eza] ))' sbin'eza'
zinit light eza-community/eza
zinit ice as"program" from"gh-r" if'! (( $+commands[bat] ))' sbin'bat'
zinit light sharkdp/bat
zinit ice as"program" from"gh-r" if'! (( $+commands[delta] ))' sbin'delta'
zinit light dandavison/delta
zinit ice as"program" from"gh-r" if'! (( $+commands[zoxide] ))' sbin'zoxide'
zinit light ajeetdsouza/zoxide
zinit ice as"program" from"gh-r" if'! (( $+commands[lazygit] ))' sbin'lazygit'
zinit light jesseduffield/lazygit
zinit ice as"program" from"gh-r" if'! (( $+commands[atuin] ))' sbin'atuin'
zinit light atuinsh/atuin


# Completion enhancements
zinit wait lucid depth"1" for \
      atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
      blockf \
      zsh-users/zsh-completions \
      atload"!_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions

zinit wait lucid light-mode depth"1" for \
      djui/alias-tips \
      zsh-users/zsh-history-substring-search \
      hlissner/zsh-autopair


#
# tmux
#
zinit ice pick'init.zsh'
zinit light laggardkernel/zsh-tmux

#
# Utilities
#

# Z
if (( $+commands[zoxide] )); then
    export _ZO_FZF_OPTS="--scheme=path --tiebreak=end,chunk,index \
           --bind=ctrl-z:ignore,btab:up,tab:down --cycle --keep-right \
           --border=sharp --height=45% --info=inline --layout=reverse \
           --tabstop=1 --exit-0 --select-1 \
           --preview '(eza --tree --level 3 --color=always \
           --group-directories-first {2} || tree -NC {2}) 2>/dev/null'"
    (( $+aliases[zi] )) && unalias zi
    eval "$(zoxide init zsh)"
else
    zinit ice wait lucid depth"1"
    zinit light agkozak/zsh-z
fi

# Git extras（用包管理器安装的版本；zinit 从源码 make install 与 brew 重复，已移除）
# brew 不把 zsh completion 链到 site-functions，需手动 source（须在 compinit 之后）
if (( $+commands[git-extras] )); then
    for _f in "$(brew --prefix git-extras 2>/dev/null)/share/git-extras/git-extras-completion.zsh" \
              /usr/share/git-extras/git-extras-completion.zsh; do
        [[ -f $_f ]] && source $_f && break
    done
    unset _f
fi

# Prettify ls（只有 gls 分支：BSD ls 不支持 --group-directories-first）
(( $+commands[gls] )) && alias ls='gls --color=tty --group-directories-first'

# FZF: fuzzy finder
if (( $+commands[brew] )); then
    FZF="$(brew --prefix)/opt/fzf/shell/"
elif (( $+commands[apt-get] )); then
    FZF="/usr/share/doc/fzf/examples/"
else
    FZF="/usr/share/fzf/"
fi

if [[ -f "$FZF/completion.zsh" ]]; then
    source "$FZF/completion.zsh"
fi

if [[ -f "$FZF/key-bindings.zsh" ]]; then
    source "$FZF/key-bindings.zsh"
fi

# Atuin（shell 历史，^R）。必须放在 fzf key-bindings 之后：fzf 会把 ^R 绑到
# fzf-history-widget，放前面会被覆盖。atuin 由 _bootstrap_tools / gh-r 兜底安装。
if (( $+commands[atuin] )); then
    eval "$(atuin init zsh)"
fi

# Git utilities powered by FZF
zinit ice wait lucid depth"1"
zinit light wfxr/forgit

# Replace zsh's default completion selection menu with fzf
zinit ice wait lucid depth"1" atload"zicompinit; zicdreplay" blockf
zinit light Aloxaf/fzf-tab

export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git || \
  rg --files --hidden --follow --glob '!.git'"
export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {} || cat {} || tree -NC {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_CTRL_R_OPTS="--preview 'echo {} | cut -f 2 | bat --color=always --plain --language=sh'
  --preview-window down:3:wrap --bind '?:toggle-preview' --exact"
export FZF_ALT_C_OPTS="--walker-skip .git,node_modules,target
  --preview '(eza --tree --level 3 --color=always --icons=auto --group-directories-first {} || \
  tree -NC {} || ls --color=always --group-directories-first {}) | head -200'"

# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# 预览文件/目录（所有命令的文件参数通用规则；更具体的 git-*/man/brew 等规则优先生效）
# 目录 → eza 列表；文件 → bat 语法高亮，--line-range :500 避免大文件卡住
#（自上游 seagle0128/dotfiles，原文 $realpath 误写成 $realpat，这里已修）
zstyle ':fzf-tab:complete:*:argument-rest' fzf-preview \
       'if [ -d $realpath ]; then \
          eza -1 --color=always --icons=auto --group-directories-first $realpath || \
          ls -1 --color=always --group-directories-first $realpath; \
        else \
          bat --color=always --plain --line-range :500 $realpath || cat $realpath; \
        fi'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
# zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# Preview environment variables
zstyle ':fzf-tab:complete:(export|unset|expand):*' fzf-preview \
       'echo ${(P)word} | bat -plhelp --color=always'

# Preivew `kill` and `ps` commands
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
       '[[ $group == "[process ID]" ]] &&
        if [[ $OSTYPE == darwin* ]]; then
            ps -p $word -o comm="" -w -w
        elif [[ $OSTYPE == linux* ]]; then
            ps --pid=$word -o cmd --no-headers -w -w
        fi'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags '--preview-window=down:3:wrap'

# Preivew `git` commands
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
	   'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
	   'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
	   'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	   'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	   'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'

# Privew help
zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:tldr:argument-1' fzf-preview 'tldr --color always $word'

# Preview brew
zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview \
       'brew info $word | bat -plhelp --color=always'

# Preview systemd
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# Commands
zstyle ':fzf-tab:complete:-command-:*' fzf-preview \
       '(out=$(tldr --color always "$word") 2>/dev/null && echo $out) ||
        (out=$(man "$word" | bat -plman --color=always) 2>/dev/null && echo $out) ||
        (out=$(which "$word") && echo $out) || echo "${(P)word}"'

# Ripgrep integration
function rgv () {
	rg --color=always --line-number --no-heading --smart-case "${*:-}" |
        fzf --ansi --height 80% --tmux 100%,80% \
            --color "hl:-1:underline,hl+:-1:underline:reverse" \
            --delimiter : \
            --preview 'bat --color=always {1} --highlight-line {2}' \
            --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
            --bind 'enter:become(emacsclient -c -nw -a "vim" +{2} {1} || vim {1} +{2})'
}

# OS bundles
if [[ $OSTYPE == darwin* ]]; then
    zinit snippet PZTM::osx
    if (( $+commands[brew] )); then
        # --greedy：连 auto_updates 的 cask 一起升，替代已废弃的 brew cu（不再依赖 buo/cask-upgrade tap）
        alias bu='brew update; brew upgrade --greedy --yes'
        alias bua='bu; brew cleanup --prune=14'
    fi
elif [[ $OSTYPE == linux* ]]; then
    if (( $+commands[apt-get] )); then
        zinit snippet OMZP::ubuntu
        alias agua='aguu -y && agar -y && aga -y'
        alias kclean+='sudo aptitude remove -P "?and(~i~nlinux-(ima|hea),\
                            ?not(?or(~n`uname -r | cut -d'\''-'\'' -f-2`,\
                            ~nlinux-generic,\
                            ~n(linux-(virtual|headers-virtual|headers-generic|image-virtual|image-generic|image-`dpkg --print-architecture`)))))"'
    elif (( $+commands[pacman] )); then
        zinit snippet OMZP::archlinux
    elif (( $+commands[zypper] )); then
        zinit snippet OMZP::suse
    fi
fi


zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
zinit light sindresorhus/pure
#
# Aliases
#

# General
alias zshconf="$EDITOR $HOME/.zshrc; $EDITOR $HOME/.zshrc.local"
alias reload='exec zsh'
alias h='history'
alias c='clear'
# alias 只对交互 shell 有意义，所以放 .zshrc 而不是 .zprofile（否则非 login 的交互 shell 拿不到）
alias sudo='sudo '
alias em='emacsclient -t -a ""'   # 终端中开 emacs
alias emc='emacsclient -nc -a ""' # emacs 图形界面

# Modern Unix commands
# See https://github.com/ibraheemdev/modern-unix
if (( $+commands[eza] )); then
    alias ls='eza --color=auto --icons=auto --group-directories-first'
    alias l='ls -lh'
    alias la='ls -lhA'
    alias lg='ls -lhA --git'
    alias tree='ls --tree'
fi
(( $+commands[bat] )) && alias cat='bat -p --wrap character'
(( $+commands[fd] )) && alias find=fd
if (( $+commands[btop] )); then
    alias top=btop
elif (( $+commands[btm] )); then
    alias top=btm
fi
# 不把 grep 别名为 rg：BSD/GNU grep 与 rg 的选项语义不同（如 rg 的 -E 是 --encoding），会静默失效
(( $+commands[tldr] )) && alias help=tldr
(( $+commands[delta] )) && alias diff=delta
(( $+commands[duf] )) && alias df=duf
(( $+commands[dust] )) && alias du=dust
(( $+commands[hyperfine] )) && alias benchmark=hyperfine
(( $+commands[gping] )) && alias ping=gping
(( $+commands[paru] )) && alias yay=paru

# Git
alias gtr='git tag -d $(git tag) && git fetch --tags' # Refresh local tags from remote

# Pi coding agent
# piq = 日常瘦身版：剔除 subagent 的 tool schema（实测每轮省约 2.8k tok 固定开销）
# 要委派子代理时用完整版 pi；想再省可把 web_search,fetch_content,get_search_content 加到列表里（再省约 2.6k）
(( $+commands[pi] )) && alias piq='pi --exclude-tools Agent,get_subagent_result,steer_subagent'

# Emacs
# 单引号：$EMACSD 由 ~/.zshrc.local 定义，双引号会在 alias 定义时（本文件靠前）展开成空
alias me='emacs -Q -l $EMACSD/init-mini.el' # mini emacs
alias mte='emacs -Q -nw -l $EMACSD/init-mini.el' # mini terminal emacs
alias e="$EDITOR -n"
alias ec="$EDITOR -n -c"
alias ef="$EDITOR -c"
alias te="$EDITOR -nw"
alias rte="$EDITOR -e '(let ((last-nonmenu-event nil) (kill-emacs-query-functions nil)) (save-buffers-kill-emacs t))' && te"

# Upgrade
alias upgrade_repo='git pull --rebase --stat origin master'
alias upgrade_dotfiles='cd $DOTFILES && upgrade_repo; cd - >/dev/null; reload'
alias upgrade_emacs='emacs -Q --batch -L "$EMACSD/lisp/" -l "init-package.el" \
                           --eval "(progn (package-initialize) (update-config-and-packages))"'
alias upgrade_zinit='zinit self-update && zinit update -a -p && zinit compinit && reload'

(( $+commands[cargo] )) && alias upgrade_cargo='cargo install cargo-update; cargo install-update -a'
(( $+commands[gem] )) && alias upgrade_gem='gem update && gem cleanup'
(( $+commands[npm] )) && alias upgrade_npm='for package in $(npm -g outdated --parseable --depth=0 | cut -d: -f2); do npm -g install "$package"; done'
(( ! $+commands[brew] )) && (( $+commands[pip] )) && alias upgrade_pip="pip list --outdated --format=json | python -c '
import json
import sys

for item in json.loads(sys.stdin.read()):
    print(\"=\".join([item[\"name\"], item[\"latest_version\"]]))
' | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U"
(( ! $+commands[brew] )) && (( $+commands[pip3] )) && alias upgrade_pip3="pip3 list --outdated --format=json | python3 -c '
import json
import sys

for item in json.loads(sys.stdin.read()):
    print(\"=\".join([item[\"name\"], item[\"latest_version\"]]))
' | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U"
(( $+commands[brew] )) && alias upgrade_brew='brew bundle --global; bua'

# Proxy
PROXY=http://127.0.0.1:6152        # ss:1088, vr:8001
NO_PROXY=10.*.*.*,192.168.*.*,*.local,localhost,127.0.0.1
alias showproxy='echo "proxy=$http_proxy"'
alias setproxy='export http_proxy=$PROXY; export https_proxy=$PROXY; export all_proxy=$PROXY; export no_proxy=$NO_PROXY; showproxy'
alias unsetproxy='export http_proxy=; export https_proxy=; export all_proxy=; export no_proxy=; showproxy'
alias toggleproxy='if [ -n "$http_proxy" ]; then unsetproxy; else setproxy; fi'

# Local customizations, e.g. theme, plugins, aliases, etc.
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local
