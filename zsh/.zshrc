# copy https://github.com/seagle0128/dotfiles/blob/master/.zshrc

# Zsh configuration

# vars
EMACSD=$HOME/.emacs.d

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
      zdharma-continuum/zinit-annex-as-monitor \
      zdharma-continuum/zinit-annex-bin-gem-node \
      zdharma-continuum/zinit-annex-patch-dl

### End of Zinit's installer chunk

# Oh My Zsh
zinit for \
      OMZL::correction.zsh \
      OMZL::directories.zsh \
      OMZL::history.zsh \
      OMZL::key-bindings.zsh \
      OMZL::theme-and-appearance.zsh

zinit wait lucid for \
      OMZP::common-aliases \
      OMZP::colored-man-pages \
      OMZP::cp \
      OMZP::extract \
      OMZP::fancy-ctrl-z \
      OMZP::git \
      OMZP::sudo


# Completion enhancements
zinit wait lucid depth"1" for \
      atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
      blockf \
      zsh-users/zsh-completions \
      atload"!_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions

zinit wait lucid light-mode depth"1" for \
      zsh-users/zsh-history-substring-search \
      hlissner/zsh-autopair \
      agkozak/zsh-z

zinit ice pick'init.zsh'
zinit light laggardkernel/zsh-tmux

if [[ $OSTYPE != linux* && $CPUTYPE != aarch* ]]; then
    zinit ice wait lucid from"gh-r" as"program"
    zinit light sei40kr/fast-alias-tips-bin
    zinit ice wait lucid depth"1"
    zinit light sei40kr/zsh-fast-alias-tips
fi

#
# Utilities
#

# Git extras
zinit ice wait lucid as"program" pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX"
zinit light tj/git-extras

# Lazygit
zinit ice wait lucid as"program" from"gh-r" sbin atload"alias lg=lazygit"
zinit light jesseduffield/lazygit

# Prettify ls
if (( $+commands[gls] )); then
    alias ls='gls --color=tty --group-directories-first'
else
    alias ls='ls --color=tty --group-directories-first'
fi

# For GNU ls (the binaries can be gls, gdircolors, e.g. on OS X when installing the
# coreutils package from Homebrew; you can also use https://github.com/ogham/exa)
# (( $+commands[gdircolors] )) && alias dircolors=gdircolors
# zinit ice depth="1" atclone"dircolors -b LS_COLORS > clrs.zsh" \
    #       atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    #       atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
# zinit light trapd00r/LS_COLORS

zinit ice wait lucid depth"1" atload"zicompinit; zicdreplay" blockf
zinit light Aloxaf/fzf-tab

zstyle ':fzf-tab:*' switch-group ',' '.'

zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:complete:*:options' sort false
zstyle ':fzf-tab:complete:(cd|ls|exa|bat|cat|emacs|nano|vi|vim):*' fzf-preview 'exa -1 --color=always $realpath 2>/dev/null|| ls -1 --color=always $realpath'
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
           fzf-preview 'echo ${(P)word}'

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

export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git || git ls-tree -r --name-only HEAD || rg --hidden --files || find ."
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '(bat --style=numbers --color=always {} || cat {} || tree -NC {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --exact"
export FZF_ALT_C_OPTS="--preview 'tree -NC {} | head -200'"

# For GNU ls (the binaries can be gls, gdircolors, e.g. on OS X when installing the
# coreutils package from Homebrew; you can also use https://github.com/ogham/exa)
zinit ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS

# OS bundles
if [[ $OSTYPE == darwin* ]]; then
    zinit snippet PZTM::osx
    if (( $+commands[brew] )); then
        alias bu='brew update && brew upgrade'
        alias bcu='brew cu --all --yes --cleanup'
        alias bua='bu && bcu'
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

# use oh-my-zsh theme
# zinit snippet OMZT::robbyrussell.zsh-theme
# ZSH_THEME="robbyrussell"

zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
zinit light sindresorhus/pure

# Local customizations, e.g. theme, plugins, aliases, etc.
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local

#
# Aliases
#

# Unalias the original fd in oh-my-zsh
# alias fd >/dev/null && unalias fd

# General
alias zshconf="$EDITOR $HOME/.zshrc; $EDITOR $HOME/.zshrc.local"
alias h='history'
alias c='clear'

alias gtr='git tag -d $(git tag) && git fetch --tags' # Refresh local tags from remote

(( $+commands[bat] )) && alias cat='bat -p --wrap character'
(( $+commands[htop] )) && alias top='htop'

if [[ $OSTYPE == darwin* ]]; then
    (( $+commands[gls] )) && alias ls='gls --color=tty --group-directories-first'
else
    ((! $+commands[exa] )) && alias ls='ls --color=tty --group-directories-first'
fi

# Emacs
alias me="emacs -Q -l ~/.emacs.d/init-mini.el" # mini emacs
alias mte="emacs -Q -nw -l ~/.emacs.d/init-mini.el" # mini terminal emacs
alias e="$EDITOR -n"
alias ec="$EDITOR -n -c"
alias ef="$EDITOR -c"
alias te="$EDITOR -a '' -nw"
alias rte="$EDITOR -e '(let ((last-nonmenu-event nil) (kill-emacs-query-functions nil)) (save-buffers-kill-emacs t))' && te"

# load xterm config
# xrdb $HOME/.Xresources
# [[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources
# if [[ $(tty) != /dev/tty* ]]; then
#     [[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
# fi

# User specific aliases and functions

# if [[ $(tty) != /dev/tty* ]]; then
#   tmux_init()
#   {
#       tmux new-session -s "chen" -d -n "local"    # 开启一个会话
#       tmux attach
#   }

#   # 判断是否已有开启的 tmux 会话，没有则开启
#   if which tmux 2>&1 >/dev/null; then
#       test -z "$TMUX" && (tmux attach || tmux_init)
#   fi

#   PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
# fi

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

[[ -f $HOME/.bashrc ]] && source  $HOME/.bashrc

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/chens/.sdkman"
[[ -s "/home/chens/.sdkman/bin/sdkman-init.sh" ]] && source "/home/chens/.sdkman/bin/sdkman-init.sh"

setopt nonomatch

alias gf=gf
