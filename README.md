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

## 📦 Installation (via Git)

### 1. Clone the repository

```bash
git clone https://github.com/Dellou-git/roseautoclose.git
```

Or download as ZIP:

* Click **Code → Download ZIP** on GitHub and extract it

---

### 2. Navigate into the folder

```bash
cd roseautoclose
```

---

### 3. Move files to a permanent location (recommended)

Example:

```
C:\Scripts\LoLRoseWatcher\
```

---

## 🔄 Updating the Script

To pull the latest updates:

```bash
git pull
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

* Change `5` to adjust how often (in seconds) the check runs — can reduce load

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

This mainly happens, when you run rose, play and then close rose / league. This won't kill the process rose.exe which will cause issues on the next start.

This script ensures:

* No manual intervention needed
* Clean environment for Rose to start properly

---

## ⚠️ Disclaimer

This script forcefully terminates processes.
Use at your own risk and ensure `Rose.exe` is safe to close in your setup.

---
