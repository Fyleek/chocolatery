@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Check if .NET Framework 4.8 is installed
echo Checking for .NET Framework 4.8...
powershell -Command "& { if (-not (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\' -Name Release | Where-Object { $_.Release -ge 528040 })) { Write-Host '.NET Framework 4.8 not found, installation required.'; Exit 1 } else { Write-Host '.NET Framework 4.8 is already installed.' } }"

IF %ERRORLEVEL% NEQ 0 (
    REM Specify the version of .NET you want to install
    set DOTNET_VERSION=6.0
    REM Display message to let user know that installation is in progress
    echo Installing .NET Framework %DOTNET_VERSION%...
    REM Download dotnet-install.ps1
    powershell -command "& { iwr -useb https://dot.net/v1/dotnet-install.ps1 -outf dotnet-install.ps1 }"
    REM Run dotnet-install.ps1 to install .NET
    powershell -command "& { .\dotnet-install.ps1 -Channel LTS -Version %DOTNET_VERSION% -InstallDir %UserProfile%\dotnet }"
    REM Delete dotnet-install.ps1
    del dotnet-install.ps1
    REM Display the installed .NET version (optional)
    echo .NET Framework %DOTNET_VERSION% is installed
dotnet --version
) ELSE (
    echo .NET Framework version is compliant
)

:: Install Chocolatey
echo Installing Chocolatey...
powershell -Command "& { Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) }"

:: Install software using Chocolatey
echo Installing software...
@REM powershell -Command "& { choco install software1; choco install software2; choco install software3; }"
REM Replace software1, software2, software3 with the Chocolatey package names of your software.

echo Installation completed.
ENDLOCAL