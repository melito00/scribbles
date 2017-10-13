@echo off

set HOME=%USERPROFILE%\home

@rem alias
doskey cat=type $*
doskey code=C:\work\VSCode-win32-x64-1.18.0-insider\bin\code-insiders.cmd $*
doskey ls=dir /a /d

