@echo off
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
git add -a *

echo Git Source Commit...
git commit -m ""

echo Git Source Push...
git push origin source

echo Done.
pause
