#!/bin/bash
# 笔记仓库自动同步：自动提交未提交的改动 + 推送未推送的 commit

REPO_DIR="$HOME/claude/note_obsidian"
LOG_FILE="$HOME/Library/Logs/note-autosync.log"

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >> "$LOG_FILE"; }

export PATH=/usr/bin:/bin:/usr/local/bin:/opt/homebrew/bin:$PATH
cd "$REPO_DIR" || { log "ERROR: 无法进入 $REPO_DIR"; exit 1; }

# 先拉取远程更新，避免冲突
if git pull --rebase --quiet 2>>"$LOG_FILE"; then
  log "pull 完成"
else
  log "ERROR: pull 失败，可能有冲突，跳过本次同步"
  exit 1
fi

# 有未提交改动或未跟踪的新文件则自动提交
if [ -n "$(git status --porcelain)" ]; then
  if git add -A && git commit -m "自动备份 $(date '+%Y-%m-%d %H:%M')" --quiet; then
    log "已提交新改动"
  else
    log "ERROR: 提交失败"
    exit 1
  fi
fi

# 有未推送的 commit 则推送
AHEAD=$(git rev-list --count @{u}..HEAD 2>/dev/null)
if [ -n "$AHEAD" ] && [ "$AHEAD" != "0" ]; then
  if git push --quiet 2>>"$LOG_FILE"; then
    log "已推送 $AHEAD 个 commit"
  else
    log "ERROR: push 失败"
  fi
else
  log "无需同步"
fi
