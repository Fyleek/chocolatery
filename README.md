# Project Documentation

## Overview

This script automates the installation of essential software tools on Windows machines. It utilizes Chocolatey, a popular package manager, to streamline the installation process. The script checks for the required .NET Framework version and then proceeds to install a list of predefined software packages.

## Prerequisites

- Windows Operating System
- .NET Framework 4.8 or higher (optional because installed by batch if not installed)
- Chocolatey package manager (optional because installed by batch if not installed)

## Features

- **.NET Framework Check**: Verifies if .NET Framework 4.8 or higher is installed.
- **Chocolatey Installation**: Automates the installation of Chocolatey if not already installed.
- **Software Installation**: Installs a predefined list of software packages using Chocolatey.

## Software Packages

The script includes the installation of the following software:
*You could find all the needed packages on [chocolatey community](https://community.chocolatey.org/packages)*

- Google Chrome
- Figma
- Python 3.12.1
- Notepad++
- Git
- Visual Studio 2022 Professional
- Notion
- Visual Studio Code
- MySQL Workbench
- PyCharm
- Postman
- Node.js
- NVM (Node Version Manager)
- PowerToys

## Installation Steps for Test/Debug

1.  *Ensure Virtualization is Enabled*: For Docker usage, ensure that virtualization is activated on your machine.
2.  *Install Docker*: If not installed, download and install Docker Desktop for Windows.
3.  *Switch Docker Environment*: Right-click on the Docker icon and switch to the appropriate environment (Windows/Linux) as needed.
4.  *Enable Windows Features*: Run `Enable-WindowsOptionalFeature -Online -FeatureName $("Microsoft-Hyper-V", "Containers") -All` in CMD to enable necessary Windows features.
5.  *Build Docker Image*: Run `docker build -t chocolatey .` to build the Docker image.
6.  *Run Docker Container*: Execute `docker run -it chocolatey cmd` to start the container.

## Usage

Run the script in a Command Prompt window as an administrator. The script will perform the following actions:

- Check for .NET Framework 4.8 or higher.
- Install Chocolatey if not present.
- Sequentially install each software package listed.
- Report any installation failures.

## Troubleshooting

If the script encounters any issues, it will provide an error message indicating the problem. Common issues might relate to network connectivity, access permissions, or conflicts with existing software versions.

## Contributing

Contributions to enhance the script, add more packages, or improve the existing functionalities are welcome.

## License

This project is open-source and can be used or modified by anyone. Please adhere to the respective licenses of the software packages being installed.

*Note: This script is developed independently and is not officially associated with the software packages or Chocolatey.*