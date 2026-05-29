@echo off
setlocal

set "BASE_DIR=%~dp0"
set "WRAPPER_PROPERTIES=%BASE_DIR%.mvn\wrapper\maven-wrapper.properties"

if not exist "%WRAPPER_PROPERTIES%" (
  echo Maven Wrapper properties not found: %WRAPPER_PROPERTIES%
  exit /b 1
)

for /f "tokens=1,* delims==" %%A in ('findstr /b "distributionUrl=" "%WRAPPER_PROPERTIES%"') do set "DISTRIBUTION_URL=%%B"

if "%DISTRIBUTION_URL%"=="" (
  echo distributionUrl not found in %WRAPPER_PROPERTIES%
  exit /b 1
)

for %%F in ("%DISTRIBUTION_URL%") do set "ARCHIVE_NAME=%%~nxF"
set "MAVEN_DIR=%ARCHIVE_NAME:-bin.zip=%"
set "WRAPPER_DIR=%USERPROFILE%\.m2\wrapper\dists\%MAVEN_DIR%"
set "ARCHIVE_PATH=%WRAPPER_DIR%\%ARCHIVE_NAME%"
set "MAVEN_HOME=%WRAPPER_DIR%\%MAVEN_DIR%"
set "MAVEN_CMD=%MAVEN_HOME%\bin\mvn.cmd"

if not exist "%MAVEN_CMD%" (
  if not exist "%WRAPPER_DIR%" mkdir "%WRAPPER_DIR%"

  echo Downloading Maven from %DISTRIBUTION_URL%
  powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%DISTRIBUTION_URL%' -OutFile '%ARCHIVE_PATH%'"
  if errorlevel 1 exit /b 1

  echo Extracting Maven to %WRAPPER_DIR%
  powershell -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -Path '%ARCHIVE_PATH%' -DestinationPath '%WRAPPER_DIR%' -Force"
  if errorlevel 1 exit /b 1
)

"%MAVEN_CMD%" %*
