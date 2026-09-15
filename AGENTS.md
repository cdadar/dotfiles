# dotfiles — Agent 速查

个人 dotfiles 仓库：顶层目录各是一个 [GNU Stow](https://www.gnu.org/software/stow/) 包，
链接到 `$HOME`。部署命令与包清单见 `README.org`，机器差异约定见 `docs/machine-local.md`。
全局约定见 `~/.pi/agent/AGENTS.md`，这里只写本仓库特有的事。

## 怎么跑

```sh
cd ~/project/private/dotfiles
stow -t $HOME <pkg>          # 部署一个包；包清单见 README.org「包清单与部署命令」
readlink ~/.zshrc            # 确认仍然是软链（见下方铁律 2）
```

## 铁律

1. **只改 master**（仓库里的文件）。`$HOME` 下的是软链，改那里等于改 master，但要先确认它还是软链。
2. **别让编辑器写穿软链**：`~/.zshrc`、`~/.bashrc`、`~/.vimrc` 等都是 `$HOME` → 仓库的软链。
   有的编辑器保存时先写临时文件再 rename，会把软链替换成普通文件 —— 之后 `$HOME` 副本与
   master 分叉、仓库改动再也不生效（本仓库踩过：`~/.zshrc` 变成 Sep 1 旧副本，master 的修复
   一直没上线）。改完 `readlink` 确认；不是软链就 `rm` 掉再 `stow -t $HOME zsh` 重建。
3. **机器/身份相关不进 master**：本机路径、代理、SSH key、公司邮箱。zsh → `~/.zshrc.local`，
   bash → `~/.bashrc.local`，git → `~/.gitconfig.{work,personal}`（原生 `includeIf`）。
   模板是同名 `.example` 文件，改 master 时同步模板。
4. **可移植性**：不写 `/Users/chens` 这类宿主路径，用 `$HOME`；判断工具存在一律用
   `(( $+commands[x] ))` 守卫，别假设装了。

## 工具兜底（两级，别拆）

`zsh/.zshrc` 里两级都靠守卫跳过，已装则零成本：

1. `_bootstrap_tools` —— 走系统包管理器（brew/apt/pacman/zypper），格式 `命令:brew:apt:pacman:zypper`。
2. zinit `from"gh-r"` —— 从 GitHub Release 下二进制，跨平台兜底。**必须用 `sbin`**：
   `lbin` 由未加载的 `zinit-annex-binary-symlink` 提供，用了会静默失效（下了二进制但不在
   PATH 上，本仓库踩过）。没有二进制 release 的（tldr/git-extras）只进第 1 级。

新增工具时两级一起加。

## 验证改动

```sh
zsh -n zsh/.zshrc && zsh -n zsh/.zprofile && bash -n bash/.bashrc
zsh -lic exit          # 应无新报错（本机噪音：非 tty 下 "can't change option: zle" 可忽略）
```

基线：启动 ~0.5s、PATH 无重复项、`comps` 非空。改完 shell 配置跑一遍再交付。

## 提交

`type(scope): 中文描述`（见 `git log`）。提交由人执行或确认后执行；**不要 push**。
