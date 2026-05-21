# Git 基础

## 常用命令

### 基本操作
```bash
git init              # 初始化仓库
git clone <url>       # 克隆远程仓库
git status            # 查看状态
git add .             # 添加所有更改
git commit -m "msg"   # 提交更改
```

### 分支操作
```bash
git branch            # 查看分支
git branch <name>     # 创建分支
git checkout <name>   # 切换分支
git checkout -b <name> # 创建并切换
git merge <name>      # 合并分支
```

### 远程操作
```bash
git remote -v         # 查看远程仓库
git push origin main  # 推送到远程
git pull              # 拉取远程更改
```
