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
