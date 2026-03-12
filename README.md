# CodeSpawn 🚀
![CodeSpawn Header](./header.png)


**CodeSpawn** is a Windows automation utility that integrates directly into your File Explorer context menu. It allows you to instantly summon your favorite AI coding agents (Claude, Gemini, Codex, Qwen) directly into your current working directory.

Instead of manually opening a terminal, creating directories, and launching your CLI tools one by one, CodeSpawn does it all in a single click. It automatically generates isolated subfolders for your workspace and launches your agents in beautifully organized, correctly titled Windows Terminal tabs.

## ✨ Features

* **1-Click Context Menu:** Right-click any folder to access the "LLM Coding Agent" menu.
* **Auto-Directory Setup:** Automatically creates `claude`, `gemini`, `codex`, `qwen3-coder` and/or `qwen3.5`  subfolders in your target path.
* **Multi-Tab Workspace:** Select "All LLMs (Tabs)" to instantly spawn all your agents side-by-side in a single Windows Terminal instance.
* **Tab Protection:** Prevents CLI tools from hijacking your tab titles so your workspace stays organized.
* **Portable Installation:** Simple PowerShell installation script that dynamically configures your registry based on wherever you save the folder.

## Ollama Models used

Besides Claude Code, Gemini and Codex, the tool uses the following Ollama models:

* [Qwen 3.5 395b in Ollama Cloud](https://ollama.com/library/qwen3.5:397b-cloud)
* [Qwen 3 Coder Next in Ollama Cloud](https://ollama.com/library/qwen3-coder-next:cloud)

---

## 📋 Prerequisites

To fully utilize CodeSpawn, you will need the following software and accounts configured on your Windows machine:

### System Requirements

* **Windows 10 or 11**
* **Windows Terminal:** Included by default in Windows 11. (Accessible via `wt.exe`).
* **PowerShell 7:** Make sure you have the modern `pwsh.exe` installed, not just the legacy Windows PowerShell (`powershell.exe`).

### AI Accounts & CLI Tools

You must have the respective CLI tools installed and authenticated on your machine. They must be accessible globally via your system's PATH variable.

* **Anthropic / Claude:** An active Anthropic account/API key and the `claude` CLI installed (e.g., Claude Code).
* **Google / Gemini:** A Google account/API key and your preferred `gemini` CLI wrapper installed.
* **OpenAI / Codex:** An OpenAI account/API key and your preferred `codex` CLI wrapper installed.
* **Ollama (for Qwen):** [Ollama](https://ollama.com/) installed locally along with an account in standing in order to use the Ollama Cloud version of the Qwen models.

---

## 🛠️ Installation

CodeSpawn uses a portable, script-based installation. You can place the folder anywhere on your machine, and the installer will dynamically link the context menu to that exact location.

1. **Download the Repository:** Clone this repo or download it as a `.zip` file and extract it.
2. **Choose a Permanent Home:** Move the unzipped folder to a permanent location on your drive (e.g., `C:\Tools\CodeSpawn` or `D:\Scripts\CodeSpawn`). *Do not move the folder after installing, or the context menu will break!*
3. **Run the Installer:** 
   * Open a PowerShell window with `Run as an administrator` and navigate to the folder with all files in the Permanent Home as set up above.
   * Right-click the `Install.ps1` file.
   * Select **Run with PowerShell**.
   * *Note: The script requires Administrator privileges to add the cascading menu to the Windows Registry. Click "Yes" when prompted by User Account Control (UAC).*

The script will read the `Install-Menu.template.reg` file, inject your current folder path, and cleanly register the context menu.

---

## 🚀 Usage

1. Open File Explorer.
2. Right-click on any folder icon.
3. Select **LLM Coding Agent**.
4. Choose the specific agent you want to launch, or select **All LLMs (Tabs)** to launch a comprehensive AI workstation.

---

## 🗑️ Uninstallation

If you ever want to remove CodeSpawn from your right-click menu:

1. Navigate to your CodeSpawn folder.
2. Double-click the `Uninstall-Menu.reg` file.
3. Click **Yes** to confirm you want to modify the registry. 
4. You can now safely delete the CodeSpawn folder from your drive.