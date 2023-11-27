---
abbrlink: 25
tags:
  - 草稿
title: Hexo
---
hexo从GitHub上克隆到本地-恢复使用操作
安装hexo:npm install -g hexo-cli
克隆GitHub上保存的hexo网站原文件:git clone url_or_ssh
生成缺少的网站文件,比如node_modules等文件夹，进入克隆的目录，执行：
npm install
npm install hexo-deployer-git --save
清理，生成、运行，hexo clean && hexo g && hexo s