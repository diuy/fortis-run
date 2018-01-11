@echo off
setlocal enabledelayedexpansion
rem set JAVA_HOME="/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.151.x86_64/jre"
rem set APP_HEAP_OPTS="-Xmx1G -Xms1G"
rem set APP_JVM_OPTS="-server -XX:+UseG1GC -XX:MaxGCPauseMillis=20 -XX:InitiatingHeapOccupancyPercent=35 -XX:+DisableExplicitGC -Djava.awt.headless=true"
set APP_OPTS=

set APP_HOME=%CD%
set APP_CLASS=com.fortis.run.Bootstrap

title %APP_HOME%

set LIB_JARS=conf
cd lib
for %%i in (*.jar) do set LIB_JARS=!LIB_JARS!;lib\%%i
cd ..

IF ["%JAVA_HOME%"] EQU [""] (
	set JAVA=java
) ELSE (
	set JAVA="%JAVA_HOME%\bin\java"
)

IF ["%APP_HEAP_OPTS%"] EQU [""] (
	set APP_HEAP_OPTS=-Xmx1G -Xms1G
)

IF ["%APP_JVM_OPTS%"] EQU [""] (
	set APP_JVM_OPTS=-server -XX:+UseG1GC -XX:MaxGCPauseMillis=20 -XX:InitiatingHeapOccupancyPercent=35 -XX:+DisableExplicitGC -Djava.awt.headless=true
)

set COMMAND=%JAVA% %APP_HEAP_OPTS% %APP_JVM_OPTS% %APP_OPTS% -cp "%LIB_JARS%;." %APP_CLASS%

echo %COMMAND%
echo.
%COMMAND%

pause