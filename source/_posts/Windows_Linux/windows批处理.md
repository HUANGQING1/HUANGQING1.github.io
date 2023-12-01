---
title: windows批处理
abbrlink: 23528
toc: true
date: 2023-12-01 09:44:04
tags:
---
# 注释、帮助文档等命令及相关资源

```
批处理命令可以分为两类：`Windows`自带命令，`Java/Python`等外部命令。
`Windows`不区分大小写，`Echo "hello world"`与`echo "hello world"` 没有区别。


REM 注释内容  注：rem是remark的缩写
:: 注释内容

help 查询windows全部自带命令
set /?   查询set命令的帮助文档
help set 查询set命令的帮助文档

pause   暂停


相关论坛：批处理之家 http://www.bathome.net/index.php
指令大全(官方)：Windows 命令https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/windows-commands
https://www.w3cschool.cn/pclrmsc/lqsenp.html
```
# 相关命令的简单使用
## echo 显示消息，或者启用或关闭命令回显。

```
ECHO [ON | OFF]   启用或关闭命令回显
ECHO [message]    显示消息

echo "hello world" 			显示  hello world

echo. 			显示空行 
```
## cd 显示当前目录名或改变当前目录。

```
cd        显示当前驱动器和目录
cd D:     显示特定驱动器的当前目录


cd ..            返回到当前目录的父目录
D:               切换到D盘
cd C:\Users      改变当前目录,切换到目录C:\Users(驱动器不变)
cd /D D:\Folder  切换到 D 驱动器的 Folder 目录

::%cd%表示当前的完整路径，显示当前的完整路径
echo 当前的完整路径是%cd%

注：cd是change directory的缩写
```
### dir：显示目录中的文件和子目录列表。
```
dir      显示当前路径所有文件和目录
dir /b   显示当前路径所有文件和目录(不带标题或摘要)

注：dir是directory的缩写
