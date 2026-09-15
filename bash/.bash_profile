# shellcheck disable=SC1091,SC2148
# rc 入口文件，不写 shebang

# ~/.bash_profile —— bash login shell 入口
# 环境全部在 .bashrc，这里只做加载（login shell 不读 .bashrc）
[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
