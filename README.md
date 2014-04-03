ShadowProtect Backup Loader
===========================

Ever needed to mount a backup file on a customers machine to pull a file out, but didn't have ShadowProtect installed or your Recovery Environment CD/USB handy?

Never again with the Backup Loader batch file!

(Ironically I have this loaded onto my Recovery Environment USB)

The SPBackupLoader batch program allows you to mount and explore a backup file or chain (.spf or .spi) from within the target system without requiring ShadowProtect components to be installed. It has teh advantage over the RE in that you can run this from any running machine, remiving the requirement to boot to the RE.

Requirements
------------

Windows 7 or higher. Has not been tested with Vista or below.

The following files from a ShadowProtect install:
   - mount.exe
   
   - sbimageapi.dll
   
   - sbmount.sys
   
   - sbmountapi.dll
   
I will not be providing these file in this project as they were not created by me.

Usage
-----

- Open an elevated-permissions command prompt (right click - Run as Administrator)

- Navigate to the root of your USB key (or the location you keep the load.cmd file). NOTE: this location **must** contain a subfolder titled *sp* and contain the above listed files therein!
 
- type: load.cmd PATH-TO-BACKUP-CHAIN-FILE DRIVE-LETTER-TO-MOUNT-TO
 
Note: the backup file path can be a UNC path - make sure to enclose it in quotes ("") if the path contains spaces.

Note: the drive letter does not require the colon (:) after the letter. The program will give an error if it detects the drive letter is already in use.

CYA
---
I make no determinations that this program will work for you, or that it's even fit for an intended purpose. If you break something, I will light a candle for you but I cannot help.

Having said that, feel free to make changes as you wish.
