@echo off
(
echo Running Hexo commands...
hexo clean && hexo g &&call copy_assets.bat

pause
hexo s

git add . && git commit -m ""
git commit -m "%date%%time%"
git push origin source

echo Done.
pause
)
