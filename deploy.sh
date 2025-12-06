#!/bin/bash

# 遇到错误立即停止
set -e

# 打印带颜色的文字函数 (绿色)
function print_green {
    echo -e "\033[32m$1\033[0m"
}

# 1. 发布博客到网站
print_green "====== 🚀 开始发布博客 (Deploy) ======"
hexo clean
hexo generate
hexo deploy
print_green "====== ✅ 博客发布完成 ======"

# 2. 备份源码到 GitHub
print_green "====== 💾 开始备份源码 (Backup) ======"

# 检查当前是否在 hexo 分支
current_branch=$(git symbolic-ref --short HEAD)
if [ "$current_branch" != "hexo" ]; then
    echo "⚠️  警告: 你当前不在 hexo 分支，正在自动切换..."
    git checkout hexo
fi

git add .
# 获取当前时间作为 Commit 信息
commit_msg="Site update: $(date '+%Y-%m-%d %H:%M:%S')"
git commit -m "$commit_msg"

# 推送到远程 hexo 分支
git push origin hexo

print_green "====== 🎉 全部流程结束！源码已安全备份 ======"