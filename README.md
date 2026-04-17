# LoL Rose Watcher

A lightweight background script that automatically monitors whether **League of Legends** is running and closes `Rose.exe` if it isn't.

## 🧠 Purpose

This script solves a known issue where **Rose** refuses to start because it detects an already running process — even though League is not actually running.

Instead of manually opening Task Manager and killing `Rose.exe`, this script does it for you automatically.

---

## ⚙️ How It Works

* Runs silently in the background (no visible CMD window)
* Checks every **5 seconds** if `LeagueClient.exe` is running
* If League is **not running**, it:

  * Checks if `Rose.exe` is active
  * Forcefully terminates it if necessary
* Automatically registers itself as a **scheduled task on logon**

---

## 📂 Files

### 1. `closerose.bat`

Main logic script:

```bat
@echo off
setlocal

set "TASKNAME=LoL Rose Watcher"
set "TARGET=LeagueClient.exe"
set "CLOSE=Rose.exe"
set "INTERVAL=5"

:: Register scheduler task to run script in background every logon
schtasks /query /tn "%TASKNAME%" >nul 2>&1
if %errorlevel% neq 0 (
    schtasks /create /tn "%TASKNAME%" /tr "wscript.exe \"C:\path\to\vbsfile\taskscheduler.vbs\"" /sc onlogon /rl highest /f >nul 
    :: Requires admin rights
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
```

---

### 2. `taskscheduler.vbs`

Runs the batch script invisibly:

```vbscript
CreateObject("Wscript.Shell").Run "cmd /c ""C:\path\to\your\script\closerose.bat""", 0, False
```

---

## 🚀 Setup Instructions

1. Place both files somewhere permanent, for example:

   ```
   C:\Scripts\LoLRoseWatcher\
   ```

2. Update paths:

   * In `taskscheduler.vbs`, replace:

     ```
     C:\path\to\your\script\closerose.bat
     ```

     with your actual path

   * In `closerose.bat`, replace:

     ```
     C:\path\to\vbsfile\taskscheduler.vbs
     ```

3. Run `closerose.bat` **once as Administrator**

   * This registers the scheduled task

4. Done ✅
   The script will now start automatically at login and run in the background.

---

## 🔒 Notes

* Requires **Administrator privileges** (for killing processes)

* Uses `LeagueClient.exe` intentionally
  ⚠️ Do **NOT** change this to the in-game process — it will break compatibility with Rose

* Runs silently (no visible windows)

---

## 🛠 Customization

You can tweak:

```bat
set "INTERVAL=5"
```

* Change `5` to adjust how often (in seconds) the check runs - can reduce load

---

## 🧹 Uninstall

To remove the script:

1. Open Command Prompt as Administrator
2. Run:

```bat
schtasks /delete /tn "LoL Rose Watcher" /f
```

3. Delete the script files

---

## 💡 Why This Exists

Due to a bug where **Rose falsely detects an already running process**, it prevents startup.

This script ensures:

* No manual intervention needed
* Clean environment for Rose to start properly

---

## ⚠️ Disclaimer

This script forcefully terminates processes.
Use at your own risk and ensure `Rose.exe` is safe to close in your setup.

---
