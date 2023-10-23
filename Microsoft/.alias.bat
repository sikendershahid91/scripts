@echo off

:: aliases 
doskey ls=dir $*
doskey runemacs="C:\Program Files (x86)\Emacs\bin\runemacs.exe" $*
doskey emacs="C:\Program Files (x86)\Emacs\bin\emacs.exe" $*
doskey ee="C:\Program Files (x86)\Emacs\bin\emacs.exe" $*
doskey e="C:\Program Files (x86)\Emacs\bin\runemacs.exe" $*
doskey cd=cd $* ^& "C:\Users\eXXXXXX\editprompt.cmd" 
doskey pwd= echo %%cd%%
doskey cdhome=cd /d "C:\Users\eXXXXXX" ^& "C:\Users\eXXXXXX\editprompt.cmd" 
doskey cdtodo=cd /d "C:\Users\eXXXXXX\Documents\REPO\todo" ^& "C:\Users\eXXXXXX\editprompt.cmd" 
doskey cdblog=cd /d "C:\Users\eXXXXXX\Documents\REPO\Blog" ^& "C:\Users\eXXXXXX\editprompt.cmd" 
doskey today=start C:\Users\eXXXXXX\Documents\REPO\Blog\TODAY.xlsx
doskey cdxhome=cd /d "X:"
doskey cdyhome=cd /d "Y:"
doskey cdzhome=cd /d "Z:"
doskey pptx="C:\Program Files\Microsoft Office\root\Office16\POWERPNT.EXE" $*
doskey docx="C:\Program Files\Microsoft Office\root\Office16\WINWORD.EXE" $*
doskey xlsx="C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE" $*
doskey chrome="C:\Program Files\Google\Chrome\Application\chrome.exe" $* 
doskey cat=type $*
 
:: browser links 
set GITLAB=https://gitlab.us.lmco.com/eXXXXXX

:: directory links
set TODO=C:\Users\eXXXXXX\Documents\REPO\todo
set BLOG=C:\Users\eXXXXXX\Documents\REPO\Blog  

:: default prompt 
prompt [$E[1;32m$n$E[0m:\\%NEWDIR%]$G
