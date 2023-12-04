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

pause   暂停执行，等待用户按任意键后继续


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
echo %var% 输出变量var到命令行界面
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
```

### set 设置变量
```
set 显示所有当前的环境变量及其值。
set P显示所有以 "P" 字母开头的环境变量

set myVar=Hello 创建一个名为 myVar 的变量，其值为 Hello
::也可以写作set myVar="Hello",因为只有String一字符串种变量类型


set /a result=5+3  创建一个名为 result 的变量，其值为 8
使用set /a时，等号右边可以是表达式

set /P var=Enter a value  ::从用户那获取一个输入设为var的值，并输出"Enter a value"


注意事项
	注意，Windows批处理命令，以一条完整的语句为处理单位(通常是一行)，在运行前，变量已经被替换为其值，比如
	set /P var=Enter a value  && echo %var%
	实际上无论输入的是什么值，打印的都是字符串%var%，因为在运行前，变量的值已被替换。
	具体参考延迟变量这部分
```

### shutdown 关机
```
:: 10s后关机
shutdown -s -t 10
```

# 逻辑判断命令
### for循环：遍历一组元素并对每个元素执行命令

```
::打印1 2 3
for %i in (1 2 3) do (echo %i)

::注意，变量应为单个字符，如%var是错误的格式
::上面是命令行中变量的表示，用%i。如果在批处理文件中，应该用%%i
:: for %%i in (1 2 3) do (echo %%i)
```
# 延迟变量
先解释下什么是一条完整的语句
```
::这是一条完整的语句
echo "var"

::for这样的含有语句块的也被视为一条完整的语句
for %i in (1 2 3) do (echo %i)

::这样的，用 && 连起来的也是一条完整的语句
set var="hello" && echo %var%
```
再解释下Windows对变量的处理
```
::输出结果是3,因为在 set var=5 && echo %var%  执行前，cmd会将变量var的值替换掉
::而该条语句执行前var值为3。
set var=3
set var=5 && echo %var% 
```
想要变量的值会在一行语句内动态变化，如何做呢？使用延迟变量。
延迟变量分为命令行中使用与批处理中使用

> 命令行中cmd /v:on与cmd /v:off可以启用与关闭延迟扩展(启用后会打开一个新的命令行外壳，在使用exit退出前，或关闭前扩展始终有效

>批处理中setlocal EnableDelayedExpansion与setlocal DisableDelayedExpansion可以启用与关闭延迟扩展
>也可以这样使用
>
>```
>setlocal EnableDelayedExpansion
>语句
>endlocal
>```
>
>延迟变量对其内的语句有效

启用延迟扩展后，用 !变量！ 的格式获取变量的值

```
setlocal EnableDelayedExpansion
::批处理中，输出结果是 5
set var=5 && echo !vari! 
::批处理中，输出结果是 hi world
set var=hello world && echo !var:hello=hi! 

::关于%PATH:str1=str2%等用法，用set /?查看
```

# 网络相关命令
## netstat显示协议统计信息和当前 TCP/IP 网络连接。

```
:: 列出所有活动的网络连接和监听端口，同时显示每个连接的远程地址、端口号和对应的进程ID等
netstat -ano   
```