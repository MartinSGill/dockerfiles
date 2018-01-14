# escape=`

FROM microsoft/dotnet-framework-build:4.7.1-2017.12

SHELL ["powershell", "-NonInteractive", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Resharper CLT
RUN Invoke-WebRequest -UseBasicParsing https://download.jetbrains.com/resharper/JetBrains.ReSharper.CommandLineTools.2017.2.2.zip -OutFile resharperclt.zip; `
    Expand-Archive -Path resharperclt.zip -DestinationPath /ReSharperCLT; `
    Remove-Item resharperclt.zip; `
    setx /M PATH $(${Env:PATH} `
    + \";C:\ReSharperCLT\")
