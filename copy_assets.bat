@echo off
set "A_PATH=./source./_posts"
set "B_PATH=./public/blog"

:: ȷ�� B_PATH/assets �ļ��д���
if not exist "%B_PATH%\assets\" mkdir "%B_PATH%\assets"

:: ���� A_PATH �е����� assets �ļ��в����������ݵ� B_PATH/assets
for /d /r "%A_PATH%" %%D in (assets) do (
    xcopy "%%D\*" "%B_PATH%\assets\" /E /I /Y
)
echo Done.
pause
