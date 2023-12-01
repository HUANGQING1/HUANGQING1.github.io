---
abbrlink: 3
title: 未命名
date: 2023-11-26 23:34:36
tags: []
toc: true
---
##### 强制删除当前目录下所有文件

```
@echo off
::文件名del.bat
::它的主要作用处理：删除一个文件需要我自己的授权，给了授权也怎么都删除不了的情况
::C盘下需要管理员权限执行
::日常删除当前目录下所有文件，用这行命令就行: rd /s/q %cd%
cd /d %~dp0
for %%F in (*) do (
	::自己就不删了
    if /I not "%%F"=="del.bat" (
        del "%%F"
    )
)
for /D %%D in (*) do (
    rd /s /q "%%D"
)
echo Done.
pause

```

##### 强制删除当前目录下指定的文件

```
::这个主要是在keil写代码时，删除中间文件，压缩项目文件体积
del *.bak /s
del *.ddk /s
del *.edk /s
del *.lst /s
del *.lnp /s
del *.mpf /s
del *.mpj /s
del *.obj /s
del *.omf /s
::del *.opt /s  ::不允许删除JLINK的设置
del *.plg /s
del *.rpt /s
del *.tmp /s
del *.__i /s
del *.crf /s
del *.o /s
del *.d /s
del *.axf /s
del *.tra /s
del *.dep /s           
del JLinkLog.txt /s

del *.iex /s
del *.htm /s
del *.sct /s
del *.map /s
exit

```
##### 将当前目录下指定文件夹中所有后缀为asset的目录移动到指定目录下
```
@echo off
set "A_PATH=./source./_posts"
set "B_PATH=./public/blog"

:: 确保 B_PATH/assets 文件夹存在
if not exist "%B_PATH%\assets\" mkdir "%B_PATH%\assets"

:: 遍历 A_PATH 中的所有 assets 文件夹并复制其内容到 B_PATH/assets
for /d /r "%A_PATH%" %%D in (assets) do (
    xcopy "%%D\*" "%B_PATH%\assets\" /E /I /Y
)
echo Done.
pause
```

##### git_hexo批处理提交程序
```
@echo off
(
echo Running Hexo commands...

echo Cleaning...
hexo clean

echo Generating...
hexo g 

echo Copying assets...
call copy_assets.bat

echo Deploying...
hexo d


echo Git Source Add...
git add . 

echo Git Source Commit...
git commit -m "%date% %time%"

echo Git Source Push...
git push origin source

echo Done.
pause
)
```

##### 将指定的各个文件_目录压缩为 指定目录下的zip文件
```
@echo off
echo 功能:将指定的各个文件/目录压缩为 指定目录下的zip文件
echo 文件目录一定要存在，否则会报错
pause 
setlocal
:: 指定需要压缩的文件/目录列表，用,分隔
::注意，压缩时隐藏文件会被无视，我使用Get-ChildIteme找到隐藏文件时，由于它会调用Get-Item（它不会传递-Force)，于是报错，解决不了。
set "filesToZip=C:\path\to\file1,C:\path\to\directory1,C:\path\to\file"

:: 指定目标ZIP文件的完整路径（包括文件名）
set "targetZip=C:\path\to\destination\archive.zip"

:: 使用PowerShell命令打包文件和目录
powershell -command "Compress-Archive -Path %filesToZip% -DestinationPath '%targetZip%' -Force"

echo Done.
pause
endlocal

```
##### 将指定的各个文件_目录压缩为 指定目录下的zip文件（一次改进版）
```
::改进后指定的文件/目录可以不存在
@echo off
echo 功能:将指定的各个文件/目录打包为指定目录下的zip文件
setlocal

:: 指定需要打包的文件/目录列表，用逗号分隔
::注意，压缩时隐藏文件会被无视，我使用Get-ChildIteme找到隐藏文件时，由于它会调用Get-Item（它不会传递-Force)，于是报错，解决不了。
set "filesToZip=C:\path\to\file1,C:\path\to\directory1,C:\path\to\file"

:: 指定目标ZIP文件的完整路径（包括文件名）
set "targetZip=C:\path\to\destination\archive.zip"

:: 分割文件/目录列表并检查每个文件/目录是否存在
setlocal enabledelayedexpansion
set "fileList="
for %%i in (%filesToZip%) do (
    if exist "%%i" (
        set "fileList=!fileList!,%%i"
    ) else (
        echo 警告: 文件或目录不存在 - %%i
    )
)

::得到的fileList开头有 , 要去掉
set fileList=%fileList:~1%

:: 使用PowerShell命令打包文件和目录，包括隐藏文件
if not "%fileList%"=="" (
    powershell -command "Compress-Archive -Path %filesToZip% -DestinationPath '%targetZip%' -Force"
) else (
    echo 没有有效的文件或目录可打包
)

echo Done.
pause
endlocal

```
##### 将指定的各个文件_目录压缩为 指定目录下的zip文件(二次改进版)
```
::二次改进版不会忽略隐藏文件夹，Compress-Archive压缩太慢，改用bandzip的提供的命令行工具压缩
@echo off
echo 功能: 使用bandzip将指定的各个文件/目录压缩为指定目录下的zip文件
setlocal

:: 指定需要打包的文件/目录列表，用空格分隔
set "filesToZip=C:\path\to\file1,C:\path\to\directory1,C:\path\to\file"

:: 指定目标ZIP文件的完整路径（包括文件名）
set "targetZip=C:\path\to\destination\archive.zip"

:: 分割文件/目录列表并检查每个文件/目录是否存在
setlocal enabledelayedexpansion
set "fileList="
for %%i in (%filesToZip%) do (
    if exist "%%i" (
        set "fileList=!fileList! %%i"
    ) else (
        echo 警告: 文件或目录不存在 - %%i
    )
)


pause

:: 使用bc命令压缩文件和目录
if not "%fileList%"=="" (
    ::压缩级别:0-9  0—仅存储，5—默认，9—最大压缩级别
    bc a -r -aoa -l:5 "%targetZip%" %fileList%
) else (
    echo 没有有效的文件或目录可打包
)

pause
echo Done.
endlocal
```
##### 将指定的zip文件夹，解压到临时目录，并将zip文件夹中的文件分别覆盖到指定目录
```
@echo off
echo 功能： 将指定的zip文件夹，解压到临时目录，并将zip文件夹中的文件分别覆盖到指定目录
pause
setlocal

:: ZIP文件路径
set "zipFilePath=C:\path\to\your\file.zip"

:: 临时解压目录
set "tempDir=C:\path\to\temp\directory"

:: 目标路径1和路径2，等等
set "targetPath1=C:\path\to\target\directory1"
set "targetPath2=C:\path\to\target\directory2"

:: 文件夹名称（在ZIP文件中）
set "folderName1=folder1"
set "folderName2=folder2"

:: 创建临时目录
md "%tempDir%"

:: 解压ZIP文件到临时目录
powershell -command "Expand-Archive -Path '%zipFilePath%' -DestinationPath '%tempDir%' -Force"

pause
:: 复制解压后的文件夹到目标路径1和2
xcopy "%tempDir%\%folderName1%" "%targetPath1%\%folderName1%" /E /I /Y
xcopy "%tempDir%\%folderName2%" "%targetPath2%\%folderName2%" /E /I /Y
pause
:: 清理临时目录（可选）
rd /s /q "%tempDir%"

echo Done.
pause
endlocal
```
##### 将指定的zip文件夹，解压到临时目录，并将zip文件夹中的文件分别覆盖到指定目录(二次改进版)
```
::Compress-Archive解压缩太慢，改用bandzip的提供的命令行工具解压缩
@echo off
echo 功能： 将指定的zip文件夹，解压到临时目录，并将zip文件夹中的文件分别覆盖到指定目录
pause
setlocal

:: ZIP文件路径
set "zipFilePath=C:\path\to\your\file.zip"

:: 临时解压目录
set "tempDir=C:\path\to\temp\directory"

:: 目标路径1和路径2
set "targetPath1=C:\path\to\target\directory1"
set "targetPath2=C:\path\to\target\directory2"

:: 文件夹名称（在ZIP文件中）
set "folderName1=folder1"
set "folderName2=folder2"

:: 创建临时目录
md "%tempDir%"

:: 使用bc命令解压ZIP文件到临时目录(
bc x -aoa -o:"%tempDir%" -target:auto "%zipFilePath%"

::由于实际上是解压到临时目录的archive目录下，所以解压文件路径是这样的
:: 复制解压后的文件夹到目标路径1和2
xcopy "%tempDir%\archive\%folderName1%" "%targetPath1%\%folderName1%" /E /I /Y
xcopy "%tempDir%\archive\%folderName2%" "%targetPath2%\%folderName2%" /E /I /Y
pause
:: 清理临时目录（可选）
rd /s /q "%tempDir%"

echo Done.
pause
endlocal
```
##### 电脑自动定期复制指定文件夹下内容到另一指定文件夹
```


```



