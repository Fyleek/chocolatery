@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Define the minimum release number for .NET Framework 4.8
SET "minReleaseNumber=528040"

:: List of software to install with their version
SET "packages=googlechrome:119.0.6045.160 figma:116.12.2 python3:3.12.1 notepadplusplus.install:8.6.0 git.install:2.43.0 visualstudio2022professional:117.8.3.0 notion:2.2.0 vscode:1.85.1 mysql.workbench:8.0.34 pycharm:2023.3.1 postman:10.19.7 nodejs:21.4.0 nvm:1.1.12 powertoys:0.76.2"
:: Variable to store installation failures
SET "failedInstalls="

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

:: Define the chocolatey executable
SET "choco=C:\ProgramData\chocolatey\bin\choco.exe"

:: Check if Chocolatey is installed
echo Checking for Chocolatey installation...
%choco% --version > nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Chocolatey is not installed. Please install it first.
    goto InstallError
)

:: Chocolatey is installed, execute your commands here
echo Chocolatey is installed. Executing commands...

:: Loop to install each software
FOR %%i IN (%packages%) DO (
    FOR /F "tokens=1,2 delims=:" %%a IN ("%%i") DO (
        SET "pkgName=%%a"
        SET "pkgVersion=%%b"
        ECHO Installing !pkgName! version !pkgVersion!...
        IF "!pkgName!"=="googlechrome" (
            !choco! install !pkgName! --version !pkgVersion! --ignore-checksums -y
        ) ELSE IF "!pkgName!"=="figma" (
            !choco! install !pkgName! --version !pkgVersion! --ignore-checksums -y
        ) ELSE (
            !choco! install !pkgName! --version !pkgVersion! -y
        )
        IF !ERRORLEVEL! NEQ 0 (
            ECHO Error occurred while installing !pkgName!.
            SET "failedInstalls=!failedInstalls! !pkgName!"
        )
    )
)

:: Display results
IF NOT "!failedInstalls!"=="" (
    ECHO The following programs could not be installed: !failedInstalls!
) ELSE (
    ECHO All programs were installed successfully.
)

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