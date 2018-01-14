# escape=`

FROM microsoft/dotnet-framework-build:3.5-windowsservercore-1709

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Resharper CLT
RUN Invoke-WebRequest -UseBasicParsing https://download.jetbrains.com/resharper/JetBrains.ReSharper.CommandLineTools.2017.2.2.zip -OutFile resharperclt.zip; `
    Expand-Archive -Path resharperclt.zip -DestinationPath /ReSharperCLT; `
    Remove-Item resharperclt.zip; `
    setx /M PATH $(${Env:PATH} `
    + \";C:\ReSharperCLT\")
