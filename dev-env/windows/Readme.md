# Windows Environment Setup

* Below is a set of notes for automating (most of) windows environment.
* Tested on Windows 10 21H1 (19043.1052)

# Pre Requisites

## 1. Windows Package Managers 

### 1.1 Winget
Brand new package manager built into windows 

* As of July 2021, it requires latest version of `app installer`
* Can install gui tools too (may need to run as admin)
* Can be run from `cmd.exe` or existing `windows powershell`
* Install it from below,
    * https://docs.microsoft.com/en-us/windows/package-manager/winget/
    * https://github.com/microsoft/winget-cli/releases

### 1.1 Scoop 

Similar to brew and doesn't require elevated permissions
    * https://scoop.sh/
    * https://github.com/lukesampson/scoop

* Ideal for cli tools including vim, grep, etc. without privilege escalation)
* Tools are installed to `~\scoop\apps\vim\current\` (~ here is %USERPROFILE%)
* `scoop which` can be used to see installation dirs (similar to `which` on linux)
* Install scoop from running `.\01_prereq_scoop_pkg_mgr.ps1` or by using below commands on `windows powershell`

    ```ps1
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
    ```
---

## 2. Install tools and software

### 2.1 Install tools (such as git, pwsh, etc) and common software using `winget`
* Open `Windows Powershell` as administrator (needed for silent install)
* Run `.\02_winget_tools.ps1`

### 2.2 Install cli tools (helm, busybox, etc.) using `scoop`
* Open `Powershell` (pwsh) via `Windows Terminal` (both installed from previous step)
* Scoop doesn't require `Admin privilege escalation`
* Run `.\03_scoop_tools.ps1`
* Relaunch terminal

---

## 3. Copy across dotfiles and configuration files

Copy across dotfiles for `Profile.ps1`, `.vimrc`, etc.
* Run `.\04_dot_files.ps1` 

---

## 4. Rust Installation (MSVC)

* Rust on Windows requires Microsoft C++ build tools 

* Install MS Visual C++ build tools 2019 from below (if not already installed)
   * https://visualstudio.microsoft.com/visual-cpp-build-tools/

* Install Rust via Rustup

* Relaunch shell and ensure `cargo` is installed as is in the `path`

```
# below command requires busybox and ripgrep from step 2.2
# From Powershell
env | grep 'Path' | tr ';' '\n' | rg 'cargo'
```
---
