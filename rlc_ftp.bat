@echo off
if "%1"=="min" goto :minimized

start /min cmd /c "%~f0" min & exit

:minimized
set source="C:\Users\ryanm\Desktop\ROBINSONS\RLC"

set destination="\\192.168.1.115\shared-folder\RLC"

xcopy %source% %destination% /E /I /Y

if %errorlevel%==0 (
    echo Folder transferred successfully!
) else (
    echo Folder transfer failed.
)