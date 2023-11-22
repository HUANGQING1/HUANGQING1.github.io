---
abbrlink: 23
tags:
  - 草稿
title: Git
---
# Git常用操作
克隆仓库：
git clone url_or_ssh

新建本地仓库，改变分支，拉取仓库
git init
git checkout -b brantch_name
git pull

远程仓库回退
git log \#查看仓库历史提交
git rest --hard 版本号  \#回退
git push -f \#强制推送

提交到远程仓库
git add *
git commit -m "更新信息"
git push origin brantch_name


hexo从GitHub上克隆到本地-恢复使用操作
安装hexo:npm install -g hexo-cli
克隆GitHub上保存的hexo网站原文件:git clone url_or_ssh
生成缺少的网站文件,比如node_modules等文件夹，进入克隆的目录，执行：
npm install
npm install hexo-deployer-git --save
清理，生成、运行，hexo clean && hexo g && hexo s