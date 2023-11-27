---
abbrlink: 23
tags: []
title: Git
---
# Git常用操作
##### 在新建文件夹下初始化仓库：

```
git init  #初始化新Git仓库(本地)
git branch -m oldName newName 		#本地分支重命名(改成main,与远程默认分支名保存一致方便些)
git remote add origin url_or_ssh  		#与远程仓库建立联系
```

##### 克隆仓库(无需先初始化仓库)：

```
git clone url_or_ssh  							#从远程克隆仓库到本地
git clone -b branch_name --depth 1 url_or_ssh  	#克隆仓库的branch_name分支的最新版本到本地
```
##### 拉取仓库

```
git pull   #从远程拉取仓库到本地(仓库需已初始化)
```

##### 提交修改

```
git add .  						#将全部修改文件添加到本地暂存区
git commit -m "本次更新信息" 		#提交修改到本地，并附上更新信息
git push origin branch_name 	#提交修改到远程仓库branch_name分支
```

##### 仓库信息查看、版本回退

```
ls  						#查看文件
git log  					#查看仓库历史提交(可查得版本号)
git rest --hard verdion_id	#回退到版本号对应的版本

```

##### 分支操作

```
git checkout -b new_branch_name 				#创建新分支并立即切换到该分支下
git checkout branch_name			 			#切换分支
git branch -m old_branch_name new_branch_name 	#分支重命名
git branch -r  									#查看远程分支列表
git branch     									#查看本地分支列表
git push origin --delete branch_name 			#删除远程分支
git branch -D branch_name   					#删除本地分支
```

##### 其他

```
git rm -r --cached .  	#清除本地缓存 (.gitignore失效时使用,清除缓存，重新提交)
git status             	# 查看当前版本状态（是否修改）
```

##### 相关参数

```
-f：强制执行
//以下为猜测
-r：远程
-b：分支
```



##### 在.gitignore文件中可用来告诉Git忽略哪些文件和文件夹，不提交。





