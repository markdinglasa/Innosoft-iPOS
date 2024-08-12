## ROBINSONS-RLC
 - 1. Make sure the Server has a shared folder
    Else, do the following.
 ```
    Navigate to the Folder:

    Open File Explorer and locate the folder you want to share.
    Right-Click and Share:

    Right-click the folder, then select Properties.
    Go to the Sharing tab and click Share.
    Choose People to Share With:

    In the Network access window, you can choose specific people or select Everyone to allow anyone on the network to access the folder.
    Click Add after selecting the user(s).
    Set the permission level (Read or Read/Write).
    Share the Folder:

    Click Share and then Done after the process completes.
    In the Sharing tab, you can also click on Advanced Sharing for more options like setting permissions.
    Note the Network Path:

    The folder’s network path will be displayed (e.g., \\YourComputerName\SharedFolderName). You can use this path to access the folder from another device.
    Ensure Network Discovery is Enabled:

    Go to Control Panel > Network and Sharing Center > Change advanced sharing settings.
    Make sure Turn on network discovery and Turn on file and printer sharing are selected.
 ```
- 2. Create/setup the rlc_ftp.bat this batch file would transfer or send the RLC folder to the server
- change the path file to send and the ServerIp and its server path location
```
    @echo off
    REM Source folder location
    set source="YOUR_RLC_FILES_TO_SEND" // change this one, this is where your pos/rlc files located at

    REM Destination folder on the target computer
    set destination="\\192.168.1.99\Users\Public\Shared-POS" // this is a sample server location, changes this one

    REM Transferring the entire folder
    xcopy %source% %destination% /E /I /Y

    REM Checking if the transfer was successful
    if %errorlevel%==0 (
        echo Folder transferred successfully!
    ) else (
        echo Folder transfer failed.
    )
    pause
```
- 3. Test the environment if the sharing data/files is working.
