@echo off
REM Source folder location
set source="C:\Users\ryanm\Desktop\ROBINSONS\RLC"

REM Destination folder on the target computer
set destination="\\192.168.1.132\Users\Public\Shared-POS"

REM Transferring the entire folder
xcopy %source% %destination% /E /I /Y

REM Checking if the transfer was successful
if %errorlevel%==0 (
    echo Folder transferred successfully!
) else (
    echo Folder transfer failed.
)

pause
