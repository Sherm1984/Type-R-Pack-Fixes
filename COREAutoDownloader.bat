@echo off
setlocal enabledelayedexpansion

title CORE Auto Downloader v1.1

echo CORE Auto Downloader v1 
ECHO WROTE FOR CORE TYPE R ONLY
ECHO EVERYONE ELSE ARE IMITATORS
ECHO P.S FUCK KEN

>NUL TIMEOUT /T 2 /NOBREAK
goto check_update

:check_update
REM Check for update by downloading the latest version of the batch file
bitsadmin /transfer "BatchUpdate" "http://yourserver.com/path/to/latest_batch.bat" "%~dp0latest_batch.bat"

REM Compare the current batch file with the latest version
FC /B "%~dp0%~nx0" "%~dp0latest_batch.bat" >NUL

IF ERRORLEVEL 1 (
    echo An update is available. Please download and install the latest version.
    REM Additional update instructions here...
    del "%~dp0%~nx0"  REM Delete the old batch file
    move "%~dp0latest_batch.bat" "%~dp0%~nx0"  REM Replace it with the latest version
    goto exit
) else (
    echo You have the latest version.
    del "%~dp0latest_batch.bat"
    goto choose
)

:choose
cls
echo[
echo[[92m===============================================================================================[0m
echo[
echo[               Choose an action:
echo[
echo[       1. Update XML
echo[       2. Download Fanart
echo[       3. Update/Reset System Configs
echo[       4. Download PC Art
echo[       5. Apply Fix/Art Update
echo[
echo[[92m===============================================================================================[0m
echo[
set /p "ACTION=Type the number next to your selection and press ENTER: "

if "%ACTION%"=="1" (
    set "LABEL=UpdateXML"
) else if "%ACTION%"=="2" (
    set "LABEL=DownloadFanart"
) else if "%ACTION%"=="3" (
    set "LABEL=UpdateSystemConfigs"
) else if "%ACTION%"=="4" (
    set "LABEL=PCARTS"
) else if "%ACTION%"=="5" (
    set "LABEL=ApplyFixArtUpdate"
) else (
    echo Invalid selection. Please try again.
    goto choose
)

goto %LABEL%

:UpdateXML
bitsadmin /transfer "List" "https://github.com/Sherm1984/Type-R-Pack-Fixes/blob/main/XMLlist.txt?raw=true" "%~dp0XMLlist.txt"

:start
cls
echo[
echo[[92m===============================================================================================[0m
echo[
echo[               Type the number of the XML you wish to update and press "ENTER"
echo[
set /a count=0

for /f "tokens=*" %%a in ('type "XMLlist.txt"') do (
    set /a count+=1
    set "line[!count!]=%%a"
)

echo Select an option:
for /l %%i in (1,1,!count!) do (
    echo %%i. !line[%%i]!
)
echo[
echo[[92m===============================================================================================[0m
echo[
set /p "SYSTEM=Type the number next to your selection and press ENTER: "
set SYSTEM=!line[%SYSTEM%]!
if [!SYSTEM!]==[] goto start
goto Update

:Update
bitsadmin /transfer "!SYSTEM!" "https://github.com/Sherm1984/Core-Type-R-XML/blob/main/!SYSTEM!.zip?raw=true" "%~dp0..\..\meta\hyperlist\!SYSTEM!.zip"

7za.exe x -Y "%~dp0..\..\meta\hyperlist\!SYSTEM!.zip" -o"%~dp0..\..\meta\hyperlist\"

del "%~dp0..\..\meta\hyperlist\!SYSTEM!.zip"

del "%~dp0..\..\meta.db"

del "%~dp0XMLlist.txt"

goto finish

REM Download Fanart

:DownloadFanart
bitsadmin /transfer "List" "https://github.com/Sherm1984/Type-R-Pack-Fixes/blob/main/FAlist.txt?raw=true" "%~dp0FAlist.txt"

:start2
cls
echo[
echo[[92m===============================================================================================[0m
echo[
echo[               Type the number of the fanart you wish to download and press "ENTER"
echo[
set /a count=0

for /f "tokens=*" %%a in ('type "FAlist.txt"') do (
    set /a count+=1
    set "line[!count!]=%%a"
)

echo Select an option:
for /l %%i in (1,1,!count!) do (
    echo %%i. !line[%%i]!
)
echo[
echo[[92m===============================================================================================[0m
echo[
set /p "FA=Type the number next to your selection and press ENTER: "
set FA=!line[%FA%]!
if [!FA!]==[] goto start2
goto Update2

:Update2
bitsadmin /transfer "!FA!" "https://github.com/Sherm1984/CORE-Fanart/blob/main/!FA!.zip?raw=true" "%~dp0..\..\!FA!.zip"

7za.exe x -Y "%~dp0..\..\!FA!.zip" -o"%~dp0..\..\"

del "%~dp0..\..\!FA!.zip"

del "%~dp0FAlist.txt"

cd "..\..\"
call fix.bat
del fix.bat

goto finish2

REM Update System Configs

:UpdateSystemConfigs
bitsadmin /transfer "List" "https://github.com/Sherm1984/Type-R-Pack-Fixes/blob/main/MBlist.txt?raw=true" "%~dp0MBlist.txt"

:start3
cls
echo[
echo[[92m===============================================================================================[0m
echo[
echo[
echo[                       Do you wish to "Update" or "Reset" a system's configs?
echo[                                            Fuck Shermo
echo[
echo[                          (U) Update
echo[                          (R) Reset
echo[
echo[
echo[[92m===============================================================================================[0m
echo[
set /p Opt=Type U to update, or R to reset and press ENTER=

if !Opt!==U set Selection=Update
if !Opt!==R set Selection=Reset
if !Opt!==u set Selection=Update
if !Opt!==r set Selection=Reset
if [!Opt!]==[] goto start3
goto System

:System
cls
echo[
echo[[92m===============================================================================================[0m
echo[
echo[               Type the number of the System you wish to update/reset and press "ENTER"
echo[
set /a count=0

for /f "tokens=*" %%a in ('type "MBlist.txt"') do (
    set /a count+=1
    set "line[!count!]=%%a"
)

echo Select an option:
for /l %%i in (1,1,!count!) do (
    echo %%i. !line[%%i]!
)
echo[
echo[[92m===============================================================================================[0m
echo[
set /p "SYSTEM=Type the number next to your selection and press ENTER: "
set SYSTEM=!line[%SYSTEM%]!
if [!SYSTEM!]==[] goto start3
goto ShermoShit

:ShermoShit
if !Selection!==Update goto Update
if !Selection!==Reset goto Reset

:Update
bitsadmin /transfer "!SYSTEM!" "https://github.com/Sherm1984/Type-R-Configs/blob/main/!SYSTEM!.zip?raw=true" "%~dp0..\..\!SYSTEM!.zip"

7za.exe x -Y "%~dp0..\..\!SYSTEM!.zip" -o"%~dp0..\..\"

del "%~dp0..\..\!SYSTEM!.zip"

del "%~dp0MBlist.txt"

goto finish

:Reset
RD /S /Q "..\..\%~dp0..\..\emulators\retroarch\config\_System\!SYSTEM!"

bitsadmin /transfer "!SYSTEM!" "https://github.com/Sherm1984/Type-R-Configs/blob/main/!SYSTEM!.zip?raw=true" "%~dp0..\..\!SYSTEM!.zip"

7za.exe x -Y "%~dp0..\..\!SYSTEM!.zip" -o"%~dp0..\..\"

del "%~dp0..\..\!SYSTEM!.zip"

goto finish

REM Apply Fix/Art Update

:ApplyFixArtUpdate
bitsadmin /transfer "List" "https://github.com/Sherm1984/Type-R-Pack-Fixes/blob/main/list.txt?raw=true" "%~dp0list.txt"

:start4
cls
echo[
echo[[92m===============================================================================================[0m
echo[
echo[               Type the number of the fix/art update you wish to apply and press "ENTER"
echo[
set /a count=0

for /f "tokens=*" %%a in ('type "list.txt"') do (
    set /a count+=1
    set "line[!count!]=%%a"
)

echo Select an option:
for /l %%i in (1,1,!count!) do (
    echo %%i. !line[%%i]!
)
echo[
echo[[92m===============================================================================================[0m
echo[
set /p "Fix=Type the number next to your selection and press ENTER: "
set Fix=!line[%Fix%]!
if [!Fix!]==[] goto start4
goto Update3

:Update3
bitsadmin /transfer "!Fix!" "https://github.com/Sherm1984/CORE-Art-and-Fixes/blob/main/!Fix!.zip?raw=true" "%~dp0..\..\!Fix!.zip"

7za.exe x -Y "%~dp0..\..\!Fix!.zip" -o"%~dp0..\..\"

del "%~dp0..\..\!Fix!.zip"

del "%~dp0list.txt"

cd "..\..\"
call fix.bat
del fix.bat

goto finish2

:PCARTS
bitsadmin /cancel
bitsadmin /transfer "List" "https://github.com/Sherm1984/Type-R-Pack-Fixes/blob/main/PClist.txt?raw=true" "%~dp0PClist.txt"

:start5
cls
echo[
echo[[92m===============================================================================================[0m
echo[
echo[               Type the number of the PC Game you wish to download the art for and press "ENTER"
echo[        
set /a count=0

for /f "tokens=*" %%a in ('type "PClist.txt"') do (
    set /a count+=1
    set "line[!count!]=%%a"
)

echo Select an option:
for /l %%i in (1,1,!count!) do (
    echo %%i. !line[%%i]!
)
echo[        
echo[[92m===============================================================================================[0m
echo[
set /p "PC=Type the number next to your selection and press ENTER: "
set PC=!line[%PC%]!
if [!PC!]==[] goto start
goto Update4	

:Update4
bitsadmin /transfer "!PC!" "https://github.com/Sherm1984/PCART/blob/main/!PC!.zip?raw=true" "%~dp0..\..\!PC!.zip"

7za.exe x -Y "%~dp0..\..\!PC!.zip" -o"%~dp0..\..\"

del "%~dp0..\..\!PC!.zip"

del "%~dp0PClist.txt"

cd "..\..\"
call fix.bat
del fix.bat
goto finish3

:finish
echo Congratulations. Action completed successfully.
pause
goto exit

:finish2
echo Congratulations. Fix applied successfully.
pause
goto exit

:finish3
echo PC Art Downloaded
pause
goto exit

:exit
choice /C YNR /M "Do you want to do more? [Y]es To Choice, [N]o to Quit, or [R]estart (To Main Menu):"

if errorlevel 3 (
    echo Restarting...
    goto choose
) else if errorlevel 2 (
    echo No selected. Exiting...
    exit /b
) else if errorlevel 1 (
    echo Yes selected. Going back to the action...
    goto %LABEL%
)