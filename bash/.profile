# ~/.profile —— POSIX sh login shell 入口（bash 有 .bash_profile 时不读本文件）
# 环境全部在 .bashrc，这里只做加载
[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
