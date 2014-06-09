@echo off
echo Cleaning temporary binary files...
del /F /S *.~dpr
del /F /S *.exe
del /F /S *.~pas
del /F /S *.~dfm
del /F /S *.~dcu
del /F /S *.dcu
echo Completed!
pause