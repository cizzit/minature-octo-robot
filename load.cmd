@echo off
REM Auto-mount of Shadowprotect backup files for file extraction.
REM Requires:
REM          - access to backup file
REM          - Administrator command prompt
REM          - a brain
REM Usage: load.cmd path-to-backup-file driver-letter-to-mount-to (without colons)

REM Limitations:
REM    - does not open password-protected backups
REM    - does not allow writeable backups
REM  For these features, see mount /?

REM Version 1.2

setlocal
echo.
echo Load Backup - (c) 2014 Stuart Rowe
echo.

REM check required files exist where expected
if not exist sp\mount.exe goto error_required_files_missing
if not exist sp\sbimageapi.dll goto error_required_files_missing
if not exist sp\sbmount.sys goto error_required_files_missing
if not exist sp\sbmountapi.dll goto error_required_files_missing

if [%1]==[] goto usage
if [%2]==[] goto usage

REM Path to backup file
set backuppath=%1
if not exist %backuppath% goto error_backup_file_not_found

REM Remove trailing colon, use only first char for drive letter
REM Note - rather than using d=auto, this way we can dismount the backup when finished
set d=%2
set drivepath=%d:~0,1%
if exist %drivepath%:\nul goto error_drive_letter_in_use

echo Loading driver...
cd sp 2>nul
if not exist mount.exe goto error_no_mount
if not exist %windir%\system32\drivers\sbmount.sys copy sbmount.sys %windir%\system32\drivers\ 2>nul
if errorlevel==1 goto error_copy_driver
mount l %windir%\system32\drivers\sbmount.sys 2>nul
REM if errorlevel==1 goto error_loading_driver
echo Driver loaded.
echo Mounting %backuppath%...
mount s %backuppath% d=%drivepath% >nul
REM Need to show errors so leave 2>nul off
echo Backup file mounted to %drivepath%:.
echo.
echo ----------------------------------------------------------
echo -                                                        -
echo -              DO NOT CLOSE THIS WINDOW!                 -
echo -                                                        -
echo -  When you have finished copying your files from the    -
echo -  backup mounted drive, press SPACEBAR in this window   -
echo -  to dismount the drive and backup file.                -
echo -                                                        -
echo - !! FAILURE TO DO SO MAY CORRUPT YOUR BACKUP FILE !!    -
echo -                                                        -
echo ----------------------------------------------------------
pause 2>nul
echo.
echo Unmounting backup...
REM unmounting backup
mount d %drivepath%: 2>nul
echo Process complete!
goto :EOF


:error_required_files_missing
echo Error: Required files missing!
echo Ensure you have a folder 'sp' in the root level of your USB
echo and that it contains the following files:
echo mount.exe, sbimageapi.dll, smbount.sys and sbmountapi.dll
goto :EOF

:error_backup_file_not_found
echo Error: Could not locate backup file (%backuppath%)
goto :usage

:error_drive_letter_in_use
echo %drivepath% is already in use, choose another drive letter
goto usage

:error_mounting_backup
echo Could not load backup (see above message).
echo Contact IT.
goto :EOF

:error_loading_driver
echo Could not load driver (see above message).
echo Contact IT.
goto :EOF

:error_copy_driver
echo Error copying driver
echo Make sure you run this from an elevated-permission command prompt.
goto :EOF

:error_no_mount
echo Cannot locate "mount.exe".
echo Please ensure this file rests in the "SP" folder on this USB key
goto :EOF

:usage
echo Usage: %0 path-to-backup-file drive-letter-to-mount-to
echo e.g. %0 F:\Backups\c_VOL.spf H
goto :EOF


:EOF
cd\
echo.