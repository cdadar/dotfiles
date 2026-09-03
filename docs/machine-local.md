# 机器差异标准（.local 机制）

dotfiles 用 **单一 master 主干**，机器差异（工作机 vs 个人机）不靠分支，靠**每机 `.local` 文件**表达。新增机器 = 复制 `.local.example` 填值，不切分支、不 rebase。

## 两种差异形态

| 形态 | 适用 | 机制 | 示例 |
|---|---|---|---|
| **追加型** | 支持 source 的软件 | 主配置末尾 `source ~/xxx.local` | vim、zsh |
| **整文件型** | 身份/整文件不同 | git 原生 `includeIf` | git user 身份 |

## 各软件标准模板

| 软件 | 示例文件 | 本机落地 | 是否已支持加载 |
|---|---|---|---|
| vim | `vim/.vimrc.local.example` | `cp vim/.vimrc.local.example ~/.vimrc.local` | ✅ 主 .vimrc 自动 source |
| zsh | `zsh/.zshrc.local.example` | `cp zsh/.zshrc.local.example ~/.zshrc.local` | ✅ 主 .zshrc 自动 source |
| git | `git/.gitconfig.local.example` | 见模板内步骤（includeIf） | ✅ git 原生 includeIf |

## 新机器接入流程

1. `git clone` dotfiles，checkout master（唯一主干）
2. 复制需要的 `.local.example` 到本机对应位置，填本机值
3. git 身份按模板加 `includeIf` 段 + 建 `~/.gitconfig.work`
4. 完成 —— 本机差异全部落在 `.local` 文件，不进分支

## 规则

- **通用配置 → 改主配置（进 master）**
- **机器特定配置 → 只进本机 `.local` 文件，不进 git**（或进仓库的 `.example` 模板）
- 新增软件需要 `.local` 支持时：主配置末尾加一行
  `[ -f $HOME/.xxx.local ] && source $HOME/.xxx.local`（bash/zsh）或对应 source 语句（vim）
  并在仓库建 `xxx/.xxx.local.example`
