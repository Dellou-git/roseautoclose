@echo off
setlocal

set "TASKNAME=LoL Rose Watcher"
set "TARGET=LeagueClient.exe" ::do not change this to leagues ingame process, it wont work with rose
set "CLOSE=Rose.exe"
set "INTERVAL=5"

:: Register scheduler task to run script in background every 5 seconds after logon - will be ignored if the task is already created.
schtasks /query /tn "%TASKNAME%" >nul 2>&1
if %errorlevel% neq 0 (
    schtasks /create /tn "%TASKNAME%" /tr "wscript.exe \"C:\path\to\vbsfile\taskscheduler.vbs\"" /sc onlogon /rl highest /f >nul 
    :: Needs admin / highest privs to be able to kill processes - change the path to your own path
    exit /b
)

:loop
tasklist /FI "IMAGENAME eq %TARGET%" 2>NUL | find /I "%TARGET%" >NUL
if errorlevel 1 (
    tasklist /FI "IMAGENAME eq %CLOSE%" 2>NUL | find /I "%CLOSE%" >NUL
    if not errorlevel 1 (
        taskkill /IM "%CLOSE%" /F >NUL
    )
)
timeout /t %INTERVAL% /nobreak >NUL
goto loop
