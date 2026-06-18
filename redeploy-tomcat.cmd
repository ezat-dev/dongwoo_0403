@echo off
setlocal

set "PROJECT_DIR=%~dp0"
set "TOMCAT_HOME=D:\apache-tomcat-9.0.115"
set "CATALINA_HOME=%TOMCAT_HOME%"
set "CATALINA_BASE=%TOMCAT_HOME%"
set "JAVA_HOME="
if exist "C:\Program Files\Eclipse Adoptium\jdk-11.0.30.7-hotspot\bin\java.exe" (
  set "JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-11.0.30.7-hotspot"
) else if exist "C:\Program Files\Java\jdk-11\bin\java.exe" (
  set "JAVA_HOME=C:\Program Files\Java\jdk-11"
)
set "JRE_HOME=%JAVA_HOME%"
set "WAR_NAME=sample_pro.war"
set "APP_DIR=sample_pro"
set "MVN_CMD="
set "MAVEN_USER_HOME=%PROJECT_DIR%.m2home"
set "MAVEN_REPO_LOCAL=%PROJECT_DIR%.m2repo"
set "BUILD_LOG=%PROJECT_DIR%redeploy-build.log"

set "PATH=%JAVA_HOME%\bin;%PATH%"

for /f "delims=" %%M in ('where mvn.cmd 2^>nul') do (
  set "MVN_CMD=%%M"
  goto :mvn_found
)
for /f "delims=" %%M in ('where mvn.bat 2^>nul') do (
  set "MVN_CMD=%%M"
  goto :mvn_found
)
for /f "delims=" %%M in ('where mvn 2^>nul') do (
  set "MVN_CMD=%%M"
  goto :mvn_found
)
if not defined MVN_CMD (
  if exist "D:\apache-maven-3.9.14\bin\mvn.cmd" (
    set "MVN_CMD=D:\apache-maven-3.9.14\bin\mvn.cmd"
  ) else (
    echo [WARN] mvn command not found.
  )
)
:mvn_found

if not exist "%TOMCAT_HOME%\bin\startup.bat" (
  echo [ERROR] TOMCAT_HOME is invalid: %TOMCAT_HOME%
  pause
  exit /b 1
)
if not defined JAVA_HOME (
  echo [ERROR] JAVA_HOME not found.
  pause
  exit /b 1
)

pushd "%PROJECT_DIR%"
echo [1/3] Building WAR...
if defined MVN_CMD (
  if not exist "%MAVEN_USER_HOME%" mkdir "%MAVEN_USER_HOME%"
  if not exist "%MAVEN_REPO_LOCAL%" mkdir "%MAVEN_REPO_LOCAL%"
  call "%MVN_CMD%" -DskipTests clean package > "%BUILD_LOG%" 2>&1
  if errorlevel 1 (
    echo [WARN] Default build failed. Retrying with local repo...
    call "%MVN_CMD%" -Dmaven.user.home="%MAVEN_USER_HOME%" -Dmaven.repo.local="%MAVEN_REPO_LOCAL%" -DskipTests clean package >> "%BUILD_LOG%" 2>&1
  )
  if errorlevel 1 goto :fail
) else (
  if not exist "target\%WAR_NAME%" (
    echo [ERROR] target\%WAR_NAME% not found.
    popd
    pause
    exit /b 1
  )
  echo [INFO] Using existing WAR: target\%WAR_NAME%
)

echo [2/3] Stopping Tomcat...
call "%TOMCAT_HOME%\bin\shutdown.bat" >nul 2>&1
timeout /t 2 /nobreak >nul

echo [3/3] Deploying WAR and starting Tomcat...
if exist "%TOMCAT_HOME%\webapps\%WAR_NAME%" del /q "%TOMCAT_HOME%\webapps\%WAR_NAME%"
if exist "%TOMCAT_HOME%\webapps\%APP_DIR%" rmdir /s /q "%TOMCAT_HOME%\webapps\%APP_DIR%"
copy /y "target\%WAR_NAME%" "%TOMCAT_HOME%\webapps\%WAR_NAME%" >nul
if errorlevel 1 goto :fail
call "%TOMCAT_HOME%\bin\startup.bat"

echo [OK] Tomcat redeploy complete.
echo [URL] http://localhost:8080/%APP_DIR%/manual
popd
pause
exit /b 0

:fail
echo [ERROR] Build failed.
echo [LOG] %BUILD_LOG%
powershell -NoProfile -Command "if (Test-Path '%BUILD_LOG%') { Get-Content -Tail 60 -Path '%BUILD_LOG%' }"
popd
pause
exit /b 1
