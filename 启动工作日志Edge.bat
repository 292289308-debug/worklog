@echo off
title 工作日志系统
cd /d "%~dp0"
start msedge --app="file:///%cd%/index.html" --window-size=1200,800 --disable-infobars
exit
