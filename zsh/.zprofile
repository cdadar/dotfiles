# shellcheck disable=SC1087,SC1090,SC1091,SC2015,SC2016,SC2086,SC2125,SC2128,SC2139,SC2148,SC2154,SC2206,SC2296
# 本文件是 zsh，ShellCheck 只认 sh/bash，说明见 zsh/.zshrc 顶部
#
# .zprofile 只被 login shell 读取：放「只对 login 有意义 / 只做一次就够」的东西
# （会 eval 子进程的集成、alias 之外的一次性初始化）。环境变量都在 .zshenv。

# ========================
# PATH 顺序压回（必须在 .zprofile，不能放 .zshenv）
# ========================

# 顺序：/etc/zshenv → ~/.zshenv → /etc/zprofile → ~/.zprofile。
# /etc/zprofile 的 path_helper 会把 /etc/paths(.d)（含 /usr/local/bin 的 brew
# node/go）前置到 PATH 最前面，把 .zshenv 里排好的顺序（volta / go sdk）盖掉，
# 所以这里恢复 .zshenv 决定的顺序（顺序定义只在 .zshenv 一处）。
_dotfiles_path_restore

# ========================
# rbenv（eval 子进程，只在 login shell 做）
# ========================

if (( $+commands[rbenv] )); then
    eval "$(rbenv init -)"
fi

# ========================
# SDKMAN（source 一个较大的脚本，只在 login shell 做）
# ========================

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
