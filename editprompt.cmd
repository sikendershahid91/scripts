@echo off

set NEWDIR=
for /f "delims=\" %%i in ('echo %CD%') do set NEWDIR=%%~nxi 

set GITBRANCH=
for /f %%I in ('git.exe rev-parse --abbrev-ref HEAD 2^> NUL') do set GITBRANCH=%%I
if "%GITBRANCH%" == "" (
    prompt [$E[1;32m$n$E[0m:\\%NEWDIR%]$G
) else (
    prompt [$E[1;32m$n$E[0m:\\%NEWDIR%]$C$E[1;31m%GITBRANCH%$E[0m$F$G
)