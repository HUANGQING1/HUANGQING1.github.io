---
title: windows
tags:
  - 草稿
abbrlink: 53166
date: 2023-11-23 03:14:43
toc: true
---




# 快捷命令

打开剪贴板：Win+V
# 简单脚本编写

```
::输出hello world

::`@`符号确保这个命令在执行时不会被显示在命令提示符窗口中。
:: 关闭命令回显，防止显示非必要的命令信息
@echo off         

:: 显示文本 "hello world" 到控制台
Echo "hello world"   

:: 暂停执行，等待用户按任意键后继续
pause                

```
批处理命令可以分为两类：`Windows`自带命令，`Java/Python`等外部命令。
`Windows`不区分大小写，`Echo "hello world"`与`echo "hello world"` 没有区别。
`echo %var% `输出变量到命令行界面
dir 
find
ipconfig
netstat -an
重定向运算
echo "hello world" >a.txt
echo "hello world" >>a.txt
<
<<
type a.txt

多命令运算 （短/断路同逻辑运算）
&& 
||

管道操作
|

## 注释、帮助文档、暂停等其它命令

```
REM 注释内容
:: 注释内容

set /?   查询set命令的帮助文档
rem /?   查询rem命令的帮助文档
help
pause   暂停

注：rem是remark的缩写
相关论坛：批处理之家 http://www.bathome.net/index.php
指令大全(官方)：Windows 命令https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/windows-commands

https://www.w3cschool.cn/pclrmsc/lqsenp.html
```

### 如何阅读帮助文档

```
表示法	说明
不含方括号或大括号的文本	必须按所显示键入的项。
<Text inside angle brackets>	必须为其提供值的占位符。
[Text inside square brackets]	可选项。
{Text inside braces}	一组必需的项。 你必须选择一个。
竖线 (|)	互斥项的分隔符。 你必须选择一个。
省略号 (…)	可重复使用多次的项。
```



### echo 显示消息，或者启用或关闭命令回显。

```
ECHO [ON | OFF]   启用或关闭命令回显
ECHO [message]    显示消息

echo "hello world" 			显示  hello world

echo. 			显示空行 
```
### cd 显示当前目录名或改变当前目录。

```
::显示当前驱动器和目录
cd
::显示特定驱动器的当前目录
cd D:

::返回到当前目录的父目录
cd ..

::切换到D盘
D:
::改变当前目录,切换到目录C:\Users\lenovo\Links(驱动器不变)
cd C:\Users\lenovo\Links
::切换到 D 驱动器的 Folder 目录
cd /D D:\Folder

::%cd%表示当前的完整路径，显示当前的完整路径
echo 当前的完整路径是%cd%

注：cd是change directory的缩写
```
### dir：显示目录中的文件和子目录列表。
```
::显示当前路径所有文件和目录
dir

::显示当前路径所有文件和目录(不带标题或摘要)
dir /b

注：dir是directory的缩写
```

## find：在文件中搜索字符串。

## set 显示、设置或删除 cmd.exe 环境变量。

##### 显示环境变量
::显示所有当前的环境变量及其值。
set  
::显示所有以 "P" 字母开头的环境变量
set p 

##### 设置变量
```
::创建一个名为 myVar 的变量，其值为 Hello
set myVar=Hello

::创建一个名为 result 的变量，其值为 8
set /A result 5+3  

::从用户那获取一个输入设为var的值，并输出
set /P var=Enter a value  
echo %var% 
```

##### 注意事项
```
::注意，Windows批处理命令，以一条完整的语句为处理单位(通常是一行)，在运行前，变量已经被替换为其值，比如
set /P var=Enter a value  && echo %var%
echo %var%

::具体参考延迟变量这部分
```
它的运行结果是这样的:
```
Enter a value  345
ECHO 处于关闭状态。
345
```

### shutdown 关机
```
:: 10s后关机
shutdown -s -t 10
```

### call从批处理程序调用另一个批处理程序。

```
:: call 批处理程序路径 参数
```

### Start 启动一个单独的窗口以运行指定的程序或命令。

```

```

### goto将 cmd.exe 定向到批处理程序中带标签的行。

### tree

### path





```
type 文本文件路径  #显示该文本文件的内容。
rd c:\a\b\c\d    #在c:\a\b\c\下删除文件夹d
md c:\a\b\c\d     #在c:\a\b\c\下创建文件夹d，如果a\b\c不存在，顺带一起创建
copy 待复制文件 目标目录 #将待复制文件复制到目标目录，xcopy是copy的扩展命令
del 待删除文件或目录路径 #删除文件或目录
ren 原文件路径+文件名 新文件名 #文件路径不变，文件重命名
move 移动文件并重命名文件和目录。
```

```
设置cmd窗口标题
title 新标题

设置控制台前景和背景色
color [attr]

标号
以:开头的字符行被视作标号。
goto
goto可以跳转到以:开头的标号处，执行标号后面的命令
```

### call

### 

### copy将一份或多份文件复制到另一个位置



### move

### ren

### replace

### attrib

### find

### fc

### ping

### ftp

### net

### ipconfig

### msg

### arp

### at

### shutdown

### tskill

### taskkill

### tasklist

### sc

### reg

### powercfg

```
三、命令释义

1、文件夹管理
cd 显示当前目录名或改变当前目录。

md 创建目录。

rd 删除一个目录。

dir 显示目录中的文件和子目录列表。

tree 以图形显示驱动器或路径的文件夹结构。

path 为可执行文件显示或设置一个搜索路径。

copy 复制文件和目录树。


2、文件管理
type 显示文本文件的内容。

copy 将一份或多份文件复制到另一个位置。

del 删除一个或数个文件。

move 移动文件并重命名文件和目录。（Windows XP Home Edition中没有)

ren 重命名文件。

replace 替换文件。

attrib 显示或更改文件属性。

find 搜索字符串。

fc 比较两个文件或两个文件集并显示它们之间的不同


3、网络命令
ping 进行网络连接测试、名称解析

ftp文件传输

net 网络命令集及用户管理

telnet远程登陆

ipconfig显示、修改TCP/IP设置

msg 给用户发送消息

arp 显示、修改局域网的IP地址-物理地址映射列表


4、系统管理
at 安排在特定日期和时间运行命令和程序

shutdown立即或定时关机或重启

tskill 结束进程

taskkill结束进程（比tskill高级，但WinXPHome版中无该命令）

tasklist显示进程列表（Windows XP Home Edition中没有）

sc 系统服务设置与控制

reg 注册表控制台工具

powercfg控制系统上的电源设置

对于以上列出的所有命令，在cmd中输入命令+/?即可查看该命令的帮助信息。如find /?
————————————————
版权声明：本文为CSDN博主「BetaGarf」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/Joker_N/article/details/89838719
```

### if判断语句

```
if语句实现条件判断，包括字符串比较、存在判断、定义判断等。通过条件判断，if语句即可以实现选择功能。

1．字符串比较

if语句仅能够对两个字符（串）是否相同、先后顺序进行判断等。其命令格式为：

IF [not] string1 compare-op string2 command1 [else command2]

其中，比较操作符compare-op有以下几类：

== - 等于

EQU - 等于

NEQ - 不等于

LSS - 小于

LEQ - 小于或等于

GTR - 大于

GEQ - 大于或等于

选择开关/i则不区分字符串大小写；选择not项，则对判断结果进行逻辑非。

字符串比较示例：

=

@echo off

set str1=abcd1233

set str2=ABCD1234

if %str1%==%str2% (echo 字符串相同！) else (echo 字符串不相同！)

if /i %str1% LSS %str2% (echo str1^<str2) else (echo str1^>=str2)

echo.

set /p choice=是否显示当前时间？（y/n)

if /i not %choice% EQU n echo 当前时间是：%date% %time%

pause>nul

对于最后一个if判断，当我们输入n或N时的效果是一样的，都不会显示时间。如果我们取消开关/i，则输入N时，依旧会显示时间。

另外请注意一下几个细节：1-echo str1^<str2和echo str1^>=str2；2-echo.。

2．存在判断

存在判断的功能是判断文件或文件夹是否存在。其命令格式为：

IF [NOT] EXIST filename command1 [else command2]

@echo off

if exist %0 echo 文件%0是存在的！

if not exist %~df0 (

echo 文件夹%~df0不存在！

） else echo 文件夹%~df0存在！

pause>nul

这里注意几个地方：

1-存在判断既可以判断文件也可以判断文件夹；

2-%0即代表该批处理的全称（包括驱动器盘符、路径、文件名和扩展类型）；

3-%~df0是对%0的修正，只保留了其驱动器盘符和路径，详情请参考for /?，属高级批处理范畴；

4-注意if语句的多行书写，多行书写要求command1的左括号必须和if在同一行、else必须和command1的右括号同行、command2的左括号必须与else同行、command1和command2都可以有任意多行，即command可以是命令集。

3．定义判断

定义判断的功能是判断变量是否存在，即是否已被定义。其命令格式为：

IF [not] DEFINED variable command1 [else command2]

存在判断举例：

@echo off

set var=111

if defined var (echo var=%var%) else echo var尚未定义！

set var=% %

if defined var (echo var=%var%) else echo var尚未定义！

pause>nul

对比可知，"set var="可以取消变量，收回变量所占据的内存空间。

4．结果判断

masm %1.asm

if errorlevel 1 pause & edit %1.asm

link %1.obj

先对源代码进行汇编，如果失败则暂停显示错误信息，并在按任意键后自动进入编辑界面；否则用link程序连接生成的obj文件，这种用法是先判断前一个命令执行后的返回码（也叫错误码，DOS程序在运行完后都有返回码），如果和定义的错误码符合（这里定义的错误码为1），则执行相应的操作（这里相应的操作为pause & edit %1.asm部分）。

另外，和其他两种用法一样，这种用法也可以表示否定。用否定的形式仍表达上面三句的意思，代码变为：

masm %1.asm

if not errorlevel 1 link %1.obj

pause & edit %1.asm
————————————————
版权声明：本文为CSDN博主「BetaGarf」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/Joker_N/article/details/89838719
```



### for循环：遍历一组元素并对每个元素执行命令

```
::打印1 2 3
for %i in (1 2 3) do (echo %i)

::注意，变量应为单个字符，如%var是错误的格式
::上面是命令行中变量的表示，用%i。如果在批处理文件中，应该用%%i
:: for %%i in (1 2 3) do (echo %%i)
```



### 延迟变量
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

### 常用符号

```
@ 回显屏蔽，表示不显示后面的命令
> 将输出信息重定向到指定的设备或文件(输出到文件时，文件原本的信息会先被擦除)
>> 将输出信息重定向到指定的设备或文件(输出到文件时，是追加而非擦除)
<,<<也是重定向符号，箭头代表其数据流向的方向不同
cls  clean screen的缩写，清屏
| 管道符号，command1|command2,将command1的输出重定向为command2的输入
^ 转义符
% 批处理变量引用
逻辑命令&、&&、||：
&连接多个命令并顺序执行，
&&连接多个命令，顺序执行。如果某个命令出错，就此停止，其后命令不执行。(说白了，就是逻辑与的判断逻辑，有0可立马确定与运算的布尔值为0，不必再向后判断)。
||连接多个命令，一直执行命令失败，直到某个命令执行成功，就此停止，其后命令不执行。
pause>nul
echo txt<a.txt
```





### 字符串运算

```
五、字符串
1、截取字符串
截取字符串可以说是字符串处理功能中最常用的一个子功能了，能够实现截取字符串中的特定位置的一个或多个字符。

举例说明其基本功能：

=========================================

@echo off

set ifo=abcdefghijklmnopqrstuvwxyz0 12 3456789

echo 原字符串（第二行为各字符的序号）：

echo %ifo%

echo 1234567890123 45678901234567890123456

echo 截取前5个字符：

echo %ifo:~0,5%

echo 截取最后5个字符：

echo %ifo:~-5%

echo 截取第一个到倒数第6个字符：

echo %ifo:~0,-5%

echo 从第4个字符开始，截取5个字符：

echo %ifo:~3,5%

echo 从倒数第14个字符开始，截取5个字符：

echo %ifo:~-14,5%

pause

=========================================

当然，上面的例子只是将字符串处理的基本功能展示出来了，还看不出字符串处理具体有什么用处。下面这个例子是对时间进行处理。

=========================================

@echo off

echo 当前时间是：%time% 即 %time:~0,2%点%time:~3,2%分%time:~6,2%秒%time:~9,2%厘秒

pause

=========================================


2、替换字符串
替换字符串，即将某一字符串中的特定字符或字符串替换为给定的字符串。举例说明其功能：

=========================================

@echo off

set aa=伟大的中国！我为你自豪！

echo 替换前：%aa%

echo 替换后：%aa:中国=中华人民共和国%

echo aa = %aa%

set "aa=%aa:中国=中华人民共和国%"

echo aa = %aa%

pause

=========================================

对于上面的例子有一点说明，对比两个echo aa = %aa%可以发现，如果要修改变量aa的内容的话，就需要将修改结果“%aa：中国=中华人民共和国%”赋值给变量aa。上面的字符串截取也有着同样的特点。


3、字符串合并
其实，合并字符串就是将两个字符串放在一起就可以了。举例说明：

=========================================

@echo off

set aa=伟大的中国！

set bb=我为你自豪！

echo %aa%%bb%

echo aa=%aa%

echo bb=%bb%

set "aa=%aa%%bb%"

echo aa=%aa%

pause

=========================================

同样，如果要改变变量aa的内容的话，就需要将合并结果“%aa%%bb%”赋值给变量aa。


4、扩充字符串
“扩充”这个词汇来自于微软自己的翻译，意思就是对表示文件路径的字符串进行特殊的处理，具体功能罗列如下：

=========================================

~I - 删除任何引号（")，扩充 %I

%~fI - 将 %I 扩充到一个完全合格的路径名

%~dI - 仅将 %I 扩充到一个驱动器号

%~pI - 仅将 %I 扩充到一个路径

%~nI - 仅将 %I 扩充到一个文件名

%~xI - 仅将 %I 扩充到一个文件扩展名

%~sI - 扩充的路径只含有短名

%~aI - 将 %I 扩充到文件的文件属性

%~tI - 将 %I 扩充到文件的日期/时间

%~zI - 将 %I 扩充到文件的大小

%~$PATH:I - 查找列在路径环境变量的目录，并将 %I 扩充

到找到的第一个完全合格的名称。如果环境变量名

未被定义，或者没有找到文件，此组合键会扩充到

空字符串

可以组合修饰符来得到多重结果：

%~dpI - 仅将 %I 扩充到一个驱动器号和路径

%~nxI - 仅将 %I 扩充到一个文件名和扩展名

%~fsI - 仅将 %I 扩充到一个带有短名的完整路径名

%~dp$PATH:i - 查找列在路径环境变量的目录，并将 %I 扩充

到找到的第一个驱动器号和路径。

%~ftzaI - 将 %I 扩充到类似输出线路的 DIR

=========================================

以上内容引用于for /?帮助信息。其中的I代表变量I，不过需要说明的是，不是所有的变量都能够进行扩充的，有两个条件：1．该字符串代表一个文件路径；2．变量要用%x来表示，x可取a-z A-Z 0-9共62个字符中的任意一个。举例说明：

=========================================

@echo off

echo 正在运行的这个批处理：

echo 完全路径：%0

echo 去掉引号：%~0

echo 所在分区：%~d0

echo 所处路径：%~p0

echo 文件名：%~n0

echo 扩展名：%~x0

echo文件属性：%~a0

echo 修改时间：%~t0

echo 文件大小：%~z0

pause

=========================================

其中的%0是批处理里面的参数，代表当前运行的批处理的完全路径。类似的还有%1-%9，分别代表传递来的第1-9个参数。例子如下：

===============================================

@echo off

set aa=C:\Windows\PPP\a.btx

call :deal aaa %aa% "c c" ddd eee

pause>nul

exit

:deal

echo %%0 = %0

echo %%1 = %1

echo %%2 = %2

echo %%3 = %3

echo %%4 = %4

echo %%5 = %5
===============================================

其中，变量aa在之前是不可以扩充的，通过call命令并将aa作为参数传递给子函数：deal，将aa变量转换成了变量%1，即符合%x格式，从而可以进行字符串扩充。

至于%x中x取a-z A-Z的形式，可以复习一下for语句，for语句里面的变量就是用%x来表示的，因而可以直接进行扩充。
————————————————
版权声明：本文为CSDN博主「BetaGarf」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/Joker_N/article/details/89838719
```



### 数值计算

```
批处理里面的数值计算功能较弱，只能够进行整型计算，忽略浮点数的小数部分；同时数值计算的范围也受限于系统位数，对于目前较为常见的32位机来说，数值计算能处理的数值范围为0x80000000h~0x7FFFFFFFh，即-2147483648~+2147483647。

数值计算需要使用set命令，具体格式为“set /a expression”。其中，expression代表计算表达式，计算表达式跟C语言里面的表达式基本上完全一致。set支持的运算符也跟C语言里面的一样，只是没有了増一减一。set支持的运算符及优先级排序如下：

=========================================

（） - 分组

！ ~ - -一元运算符（逻辑非、按位非、取负）

* / % - 算数运算符（乘、除得商、除得余数，即取余）

+ - - 算数运算符（加、减）

<< >> - 逻辑移位（左移一位、右移一位）

& - 按位“与”

^ - 按位“异”

| - 按位“或”

= *= /= %= += -= - 赋值

&= ^= |= <<= >>=

，-表达式分隔符（set可一次处理多个表达式）

=========================================

我们知道，批处理中取变量的值是需要用%或者！的，而在set /a 中，直接用变量名称即可取得变量的值。另外，set支持八进制（数字前缀0）、十进制（数字无前缀）和十六进制（数字前缀0x），且支持不同进制之间的计算，如set /a a=123+0123+0x123，计算及显示结果为十进制。
————————————————
版权声明：本文为CSDN博主「BetaGarf」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/Joker_N/article/details/89838719
```

### 参数传递

```
3、参数
跟C语言类似，在调用函数或其他批处理时可能需要传递参数。批处理的参数传递分为直接和间接两种传递参数的方法。

【 1．直接传递 】

直接传递参数，即在使用call命令时，不使用任何参数，在子函数或子批处理里面直接对主函数（也称父批处理）里面的变量进行修改。这跟汇编语言里面的参数传递方式类似。

直接传递参数举例：

===============================================

@echo off

setlocal enabledelayedexpansion

set var=aCdehiM,?mnrstW y

echo %var%

call :deal

setlocal disabledelayedexpansion

set var=%var:?=!%

echo %var%

pause>nul

exit

:deal

set tm=!var!

set var=

for %%i in (6,3,11,11,16,15,1,4,11,5,12,13,9,0,12,7,15,14,5,10,2,16,18,8) do (

set var=!var!!tm:~%%i,1!

）

goto :eof

===============================================

可以发现，当我们把变量var作为参数赋予子函数：deal后，子函数对var的值进行了修改；当子函数返回后，主函数里面的var的值就已经是子函数里面var被修改后的值了。

该例子中，使用了本节课前面讲到的setlocal enabledelayedexpansion和setlocal disabledelayedexpansion，前者保证了var在for循环里面能够根据我们的意愿进行处理，后者保证了能够正确输出符号"!"。另外例子中还使用了命令set，利用set对字符串进行了处理。还有一个地方使用了语句goto :eof，该语句相当于C语言里面的return或汇编语言里面的RET，即子程序返回命令。需要说明的是，当子函数本身就在批处理文件的末尾的话，我们是可以省略这句话的，比如将此例的goto :eof删除是不会产生任何影响的。

【 2．间接传递 】

间接传递参数，即在使用call命令时，在其后面添加参数，形如call {[:label][ChildBatch]} Parameter1 Parameter2 ... ParameterN。这跟C语言里面传递参数的格式类似。不同于C语言，批处理中的子函数不需要定义形参，更不需要指定参数的个数。传递过来的参数，在子函数或子批处理里面是以%1~%9的形式表示的，即%1~%9分别表示传递过来的第1~9个参数。

===============================================

@echo off

call :deal aaa bbb "c c" ddd eee

pause>nul

exit

:deal

echo %%0 = %0

echo %%1 = %1

echo %%2 = %2

echo %%3 = %3

echo %%4 = %4

echo %%5 = %5

===============================================

通过这个例子就可以清晰的看到%n参数表示法的用法。参数列表中包含空格的依旧要用双引号（")引起来；另外，也可以看到，%0已经变成了子函数的标号了，而不是父批处理的文件名全称。

【 3．区别 】

这两种参数传递方法本质上是没有区别的，形式上，直接传递直接对原变量进行操作，丢失了原变量的值；间接传递则通过%n对原变量进行了简单的备份，并且通用性更强，即不限定原变量的名称。另外，使用%n还有一个非常大的好处，就是可以通过%~*i来加强处理变量的能力。关于%~*i，详细内容参见for /?。

针对二者的差别，可以根据情况决定使用哪种传递方式：

--1．作为参数的变量名固定、且在子函数中不需要对其进行备份的情况下，使用直接传递法；

--2．若将子函数作为一个通用的程序模块，以适应于对不同变量的处理，或者作为参数的变量不需要备份时，使用间接传递法。

具体使用哪种方法，还需根据实际情况或使用习惯进行选择。


4、返回值
有些命令在执行之后将会返回一定的错误值（errorlevel），可以通过errorlevel的值判断命令执行的状况。这点类似于C语言里面的exit(num），num就是错误代码。

获取返回值errorlevel的方法就是，在执行命令后，立马调用返回值errorlevel，如echo %errorlevel%或者if %errorlevel%==1等命令。

errorlevel举例：

===============================================

@echo off

reg add HKCU /v try /f>nul

reg delete HKCU /v try /f

if errorlevel 0 (echo删除成功！） else (echo 删除失败！）

reg delete HKCU /v try /f

if %errorlevel%==0 (echo 删除成功！） else (echo 删除失败！）

pause>nul

===============================================

上面例子中，由于第一成功的删除了注册表，导致第二次因为找不到注册表而宣告失败。同时我们也看到了errorlevel的使用方法，即if errorlevel 0和if %errorlevel%==0是一样的。也许你注意到了，里面还有个笑脸呢~O（∩_∩）O哈哈~这就是ASCII码啦，后面跟你讲啊…

一般情况下，程序或命令成功执行时，返回的errorlevel是0，错误时返回1或更高的值。当然，有些命令是没有返回值的，这点需要注意。

嗯，有没有想起前面有个类似的东西啊？对了，那就是||和&&；了，这两个符号就是根据errorlevel的值来进行逻辑判断的。
————————————————
版权声明：本文为CSDN博主「BetaGarf」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/Joker_N/article/details/89838719
```





```
5、ASCII码
前面的例子中，我们已经使用过一次ASCII码了，也就是那个笑脸。ASCII码是图形化的符号，可以用来点缀我们的批处理的。

在cmd窗口中我们可以通过任意一个字符的ASCII码来输入该字符，比如Ctrl+G、Ctrl+N等，字母a-z对应ASCII码的97-122。对于ASCII码大于26的字符，可以通过这个方法来输入：按住Alt键不松，通过小键盘输入ASCII码的十进制值，松开Alt键即可。


6、ArcGIS中的批处理
可别告诉我您不知道什么是批处理，当面对一大堆需要重复操作的数据时，往往让我们感到头大，这时候我们会想到批处理[1]  ，那ArcGIS给大家提供了哪些批处理的方法呢，让我们拭目以待。

假设我们需要给道路建立缓冲区，设计到的工具为Buffer。

第一种情况，一个图层中不同要素建立不同大小的缓冲区

不同类型的道路，我们需要建立不同大小的缓冲区，比如，一级道路建立10米的缓冲区，二级道路建立15米的缓冲区，三级道建立20米的缓冲区。

步骤：

1、 首先应该保证你的道路数据里面有一个属性字段是用来存储Buffer宽度信息的。

2、 应用Buffer工具，在对应的参数位置选择相应字段即可。

第二种情况，不同的图层建立不同大小的缓冲区

假设还有其他不同的数据，不仅仅是道路，这些图层都需要建立缓冲区。

步骤：

1、 找到Buffer工具，右键，选择Batch，打开批处理面板。从该面板上我们可以发现，参数与我们打开Buffer的参数是一样的，这个时候是不是可以考虑在EXCEL中批量编辑好，然后复制过来呢

2、 在Excel中编辑需要的数据。

3、 将在Excel中编辑的数据复制到Buffer的批处理面板中来。此处需要注意，如果要复制10行数据，需要在批处理面板中先选中10行，右键单击，选择“paste”。

4、 点击OK即可。

如果想要每个图层中每种类型的数据的缓冲区宽度都不一样，该怎样处理的?这个留给您来尝试吧，原理很简单，就是找到参数位置，写上对应的字段即可。

第三种情况，Python实现批处理

如果您觉得上面的方法比较麻烦，而且要求也比较严格，您可以考虑应用Python来处理。

步骤：

1、 编写代码

import arcpy,os

inFCs = arcpy.GetParameterAsText(0)

outWS = arcpy.GetParameterAsText(1)

dist = arcpy.GetParameterAsText(2)

inFCs = inFCs.split(";")

for inFC in inFCs:

fileName =os.path.split(inFC)[1]

arcpy.Buffer_analysis(inFC,outWS + "\\" + fileName, str(dist) + "meter")

上面这段代码，要求用户自己设置输入数据、输出数据、缓冲区宽度(单位为米)。这里输出缓冲区数据的名称和输入数据的名称一样，如果不想要这样，可以进一步修改代码。

2、 接下来将该代码增加到ArcToolbox中，步骤比较简单，这里不再赘述。

需要注意的地方为最后的参数设置部分，”输入数据”的“MutiValue”属性设置为”Yes”。(此部分的参数设置较条条框框较多，需要与你的代码相互对照)

3、 完成后，工具将会添加到您自己的工具箱中。打开该工具，您会看到界面像普通工具的界面一样，输入数据可以设置很多个，但是这个工具所有图层的缓冲区大小必须一样。


八、注意
1、解决中文乱码问题

REM 声明采用UTF-8编码

chcp 65001

2、获取路径

@echo off
echo 当前路径：%cd%
echo 当前盘符：%~d0 
echo 当前盘符和路径：%~dp0 
echo 当前批处理全路径：%~f0 
echo 当前盘符和路径的短文件名格式：%~sdp0 
echo 当前CMD默认目录：%cd% 
pause
九、参考链接
1、百度百科：https://baike.baidu.com/item/%E6%89%B9%E5%A4%84%E7%90%86
————————————————
版权声明：本文为CSDN博主「BetaGarf」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/Joker_N/article/details/89838719
```



```
将批处理转化为可执行文件
```

### choice

