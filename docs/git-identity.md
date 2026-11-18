# Git 身份判定（本机身份层）

机器的 git 身份判定：按**工作目录**和**远端 URL** 自动切换 `user.name` / `user.email`。
模板在 `git/.gitconfig.local.example`（只有规则块），本文件是手册：规则为什么这样排、
边界在哪、丢了怎么恢复、恢复后怎么验。

## 文件落点

| 文件 | 内容 | 进 git |
|---|---|---|
| `~/.gitconfig` | 软链到 `dotfiles/git/.gitconfig`（master，公开） | ✅ |
| `~/.gitconfig.work` | 公司身份 | ❌ 本机手写 |
| `~/.gitconfig.personal` | 个人身份，同时充当 master 顶部 `[user]` 的基线 | ❌ 本机手写 |
| `~/.gitconfig.local` | 身份判定规则（由模板照抄 + 填真值） | ❌ 本机手写 |

master 与 `.gitconfig.local` 的分工：**规则一律不进 master**（规则里全是本机目录布局、
公司域名、个人账号），master 只留基线身份、通用配置、公司 GitLab 的 `insteadOf`，
以及文件最末尾的 `[include] path = ~/.gitconfig.local` 一行入口。

## 规则顺序（写在 `~/.gitconfig.local`，后面的覆盖前面的）

```
gitdir:<公司项目根>              → work
gitdir:<公司项目根>/<个人目录>    → personal   （公司私有库靠 URL 规则抢回来）
hasconfig 个人账号白名单          → personal   （github 只列 ssh + https 两种写法）
hasconfig 公司远端                → work       （放最后：多远端冲突时落安全侧）
其余                              → master 顶部 [user] 的基线身份（= personal）
```

顺序是有意的：`hasconfig` 对「一个仓库挂多个远端」会匹配任意一个，把公司规则排在最后，
冲突时判成公司身份（少个邮箱），而不是把私人邮箱写进公司历史。

## master 里仍存在的机器/身份相关项

改规则时别漏掉这三处：

1. **顶部基线身份**，同时是 `.gitconfig.local` 缺失时的兜底：

   ```ini
   [user]
   	name = <个人姓名>
   	email = <个人邮箱>
   ```

2. **文件末尾的入口**，必须在最末尾（同键值后出现的覆盖前面的）：

   ```ini
   [include]
   	path = ~/.gitconfig.local
   ```

3. **公司 GitLab 的 `insteadOf`**，必须无条件全局，**不要**搬进条件段：

   ```ini
   [url "git@<公司 GitLab 域名>:"]
   	insteadOf = https://<公司 GitLab 域名>/
   ```

   理由：go 拉私有模块时 git 子进程的 cwd 在 `~/.go/pkg/mod/cache/vcs/` 下，
   `gitdir` 规则不生效。这条失效会直接报错（响声失败，可接受，别指望它默默好使）。

## 身份文件内容（不进 git，换机器必须重建）

`~/.gitconfig.work` —— 公司身份，**email 故意留空**：公司仓库不写入任何私人邮箱，
提交者显示为 `<公司身份名> <>`。

```ini
[user]
	name = <公司身份名>
	email =
```

`~/.gitconfig.personal`：

```ini
[user]
	name = <个人姓名>
	email = <个人邮箱>
```

## 占位符 ↔ 真值从哪来

模板与本文只写占位符（dotfiles 是公开仓库）。恢复时从下列位置抄真值：

| 占位符 | 真实值从哪找 |
|---|---|
| `<个人姓名>` / `<个人邮箱>` | `~/.gitconfig.personal`、master 顶部 `[user]` |
| `<公司身份名>` | `~/.gitconfig.work` |
| `<公司项目根>` | 本机公司代码根目录名（gitdir 规则第一段） |
| `<个人目录>` | 公司项目根下的个人子目录名（gitdir 规则第二段） |
| `<你的 GitHub 账号>` | github.com 上的账号名 |
| `<公司 GitLab 域名>` | master 的 `[url ...] insteadOf` 段 |
| `<公司其它托管域名>` | 公司代码托管平台域名（自建 GitLab / Codeup / Gitea 等） |
| `<dotfiles 仓库>` | clone 下来的 dotfiles 目录 |

公司 GitLab 域名在配置里出现两次（`.gitconfig.local` 的 `hasconfig` + master 的
`insteadOf`），换域名时两处同改，否则一边认得出、一边认不出。

## 已知边界（判断不出来时落到哪里，出问题先看这里）

1. `hasconfig` 只认 `remote.*.url`。无远端的库（本地临时 `git init`）、家里自建托管，
   一律回退 `gitdir` 规则或基线 → 落到 personal。这是基线留在 personal 的原因：
   误判方向是「个人库少一层保护」，不会把私人邮箱写进公司历史。
2. 缺口：公司若另有托管平台（Codeup / 自建 Gitea 等）没配 URL 规则，就只靠 `gitdir` 规则；
   clone 到公司目录之外会判成 personal。补法是在 `~/.gitconfig.local` 里再抄一条：

   ```ini
   [includeIf "hasconfig:remote.*.url:git@<公司其它托管域名>:**/**"]
   	path = ~/.gitconfig.work
   ```

3. 一个库挂多个远端时 `hasconfig` 匹配任意一个，最终由「最后一个匹配的规则」决定 ——
   公司规则排最后，所以公司远端 + 个人远端并存 → 公司身份。
4. `hasconfig` 需 Git >= 2.36；glob 必须写成 `:**/**`，写成 `:**` 不匹配（实测静默失效）。
5. `hasconfig` 不认命令行 `-c` 传的远端 URL，也不认其它 include 文件里定义的远端。
6. `[include]` 指向的文件不存在时被静默忽略（不报错）。**实测后果**：`~/.gitconfig.local`
   一旦丢失，公司库会回落成基线个人身份，且没有任何提示。
7. 身份文件是 include 进来的，仓库自己的 `.git/config` 优先级更高：单库临时改身份直接
   在该库 `git config user.{name,email}` 即可，不必动全局。

## 恢复后自检

期望值写死在表里，逐条对照，别只看「没报错」。

**一条命令全查**（7 项，见 `script/personal/git_identity_check.sh`）：

```sh
<script 仓库>/personal/git_identity_check.sh
# 退出 0 = 全过；退出 1 = 按 [FAIL] 逐条修
```

它查的就是本文档的契约：master 无 `includeIf`、`.gitconfig.local` 规则形状与 fail-safe 顺序、
模板与手册的隐私（无真实邮箱/账号/域名/目录名）、模板规则与实际 `.gitconfig.local` 逐条一致、
实库身份 vs 应有身份、探针矩阵（临时库验方向）。

**手工最小核验**：

```sh
git config -f ~/.gitconfig --list > /dev/null && echo OK
git config -f ~/.gitconfig.local --list > /dev/null && echo OK
git -C <dotfiles 仓库> config --show-origin user.email    # 看命中的是哪个文件
git -C <某个公司库> var GIT_AUTHOR_IDENT                   # git 真正写进提交的身份
```

期望：`<dotfiles 仓库>` 命中 `.gitconfig.personal` → `<个人姓名> <<个人邮箱>>`；
公司库 → `<公司身份名> <>`（email 为空）。

## 新机器 checklist

1. clone dotfiles，`stow`（`~/.gitconfig` 必须是软链，`readlink` 确认）
2. 建 `~/.gitconfig.work`、`~/.gitconfig.personal`（本文件「身份文件内容」一节原文 + 真实值）
3. 建 `~/.gitconfig.local`：照抄 `git/.gitconfig.local.example`，占位符换成本文件「占位符 ↔ 真值来源」的真值
4. 核对 master 末尾有 `[include] path = ~/.gitconfig.local`，且 master 里没有 `includeIf`
5. 跑 `script/personal/git_identity_check.sh`，全 PASS 才算完
