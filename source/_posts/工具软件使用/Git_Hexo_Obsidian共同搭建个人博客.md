---
abbrlink: 2
tags:
  - 草稿
title: Git_Hexo_Obsidian共同搭建个人博客
---
# 安装



- 安装Git、Node.js、安装Hexo、
- GitHub创建个人仓库创建，仓库公开，仓库名必须是"账号名.github.io"
- 生成SSH添加到GitHub
- hexo部署到GitHub站点文件夹下_config.yml文件中,这段代码替换原本的deploy部分代码 
```
deploy:
	  type: git
	  repo: git@github.com:账号名/账号名.github.io.git #实际上就是SSH
	  branch: branch_name #你的分支名，一般远程仓库默认分支名是main
```
- 7.设置个人域名(如果你买了的话)
	省略，想偷懒了
- 8.发布文章
```
hexo init [folder]  			#新建一个网站
hexo new page page_name  		#新建分页
hexo new article_name			#新建文章
hexo new draft draft_name 		#新建草稿
hexo clean						#清除本地hexo缓存文件
hexo s 							#运行本地服务器（预览）
hexo g 							#生成静态文件
hexo d 							# 部署到服务器(发布)
hexo g -d 						#生成并部署文件
hexo clean && hexo g && hexo d
```

# 对应库的安装

```
给我自己看的，并不是说非要安装这些库

Obsidian推荐库：
Copy Block link：很方便的进行块引用和块嵌入
Custom Attachment location：使得typora中的图片保存位置与Obsidian兼容
Hidden Folder：兼容Obsidian与Hexo，隐藏文件，美化显示

Hexo推荐库：
hexo-abbrlink # 生成永久文章链接，方便链接复制等(链接中有中文时，字符串编码很长)
hexo-blog-encrypt #加密文章
hexo-renderer-pandoc #将markdown文件变成html文件，方便编写latex数学公式
valine  #实现评论功能
下面的大多是官方插件之类的，换主题时基本上顺便下载了
hexo-deployer-git 
hexo-autonofollow
hexo-cli
hexo-directory-category
hexo-front-matter
hexo-fs
hexo-generator-archive
hexo-generator-category
hexo-generator-feed
hexo-generator-index
hexo-generator-json-content
hexo-generator-sitemap
hexo-generator-tag
hexo-i18n
hexo-log
hexo-pagination
hexo-renderer-ejs
hexo-renderer-stylus
hexo-server
hexo-theme-landscape
hexo-util
```
# Obsidian使用时遇到的问题
## 如何兼容Obsidian与Typora图片保存位置等
Typora进行如下配置，保存位置改为./assets/\${filename}.assets
![](assets/Obsidian.assets/Typora中图片保存位置设置.png) 下载插件Custom Attachment location，然后进行如下配置，保存位置改为./assets/${filename}.assets：
![](assets/Git_Hexo_Obsidian共同搭建个人博客.assets/Custom_Attachment_Location插件图片位置配置.png)
![](assets/Obsidian.assets/Obsidian中图片位置的配置.png)

## 兼容Hexo与Typora的图片设置

## 兼容Obsidian与Hexo
[Hexo + Obsidian + Git 完美的博客部署与编辑方案 - 掘金 (juejin.cn)](https://juejin.cn/post/7120189614660255781) 
## \<Img\>标签图片不能正常显示
采用绝对路径
![Obsidian中html的img标签如何正常使用](assets/Git_Hexo_Obsidian共同搭建个人博客.assets/Obsidian中html的img标签如何正常使用.png)

## Obsidian中如何在关系图图谱中隐藏png等附件文件
首先，我使得Obsidian中的图片保存与Typora保持一致了。
在此基础上，将其设置为附件文件夹即可。
![](assets/Git_Hexo_Obsidian共同搭建个人博客.assets/Obsidian中如何在关系图图谱中隐藏png等附件文件.jpeg)

## 加密文章
使用插件：hexo-blog-encrypt


# 添加评论区(可选)
参考教程：https://cloud.tencent.com/developer/article/1946684

