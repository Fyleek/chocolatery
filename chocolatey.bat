@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Define the minimum release number for .NET Framework 4.8
SET "minReleaseNumber=528040"
:: Define the chocolatey executable
SET choco="C:\ProgramData\chocolatey\bin\choco.exe"

:: Check if .NET Framework 4.8 or higher is installed
echo Checking for .NET Framework 4.8 or higher...
REG QUERY "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /v Release > nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    FOR /F "tokens=3" %%G IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /v Release') DO SET "dotNetVersion=%%G"
    IF !dotNetVersion! GEQ %minReleaseNumber% (
        echo .NET Framework 4.8 or later is installed.
    ) ELSE (
        echo .NET Framework 4.8 or later is not installed.
        goto InstallError
    )
) ELSE (
    echo Unable to determine the .NET Framework version installed.
    goto InstallError
)

:: Install Chocolatey
echo Installing Chocolatey...
powershell.exe -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
if errorlevel 1 goto InstallError

:: Check if Chocolatey is installed
echo Checking for Chocolatey installation...
%choco% --version > nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Chocolatey is not installed. Please install it first.
    goto InstallError
)

:: Chocolatey is installed, execute your commands here
echo Chocolatey is installed. Executing commands...

:: Example Chocolatey command
@REM choco install somepackage -y
@REM IF %ERRORLEVEL% NEQ 0 (
@REM     echo Error occurred while installing somepackage.
@REM     goto InstallError
)

:: Add more Chocolatey commands here
:: ...

:: Checking if errors have occurred in PowerShell
if errorlevel 1 (
    echo An error occurred while running commands in PowerShell.
    goto InstallError
)

goto EndScript

:InstallError
echo An error occurred during the installation. Please check the error message above.

:EndScript
echo Script execution finished. Press any key to exit.
pause >nul
ENDLOCAL