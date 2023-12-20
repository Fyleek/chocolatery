# This Dockerfile is used to create a containerized Windows environment for testing purposes.
# The container will include the Server Core version of Windows Server 2022, which is a
# lightweight version of Windows without a GUI, suitable for running background applications.
# Use Windows Image
FROM mcr.microsoft.com/windows/servercore:ltsc2022
# Copy script into the container
COPY chocolatey.bat C:/chocolatey.bat