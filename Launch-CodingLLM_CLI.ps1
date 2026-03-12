param(
    [Parameter(Mandatory=$true)]
    [string]$TargetDirectory,

    [Parameter(Mandatory=$true)]
    [ValidateSet('claude', 'gemini', 'codex', 'qwen3-coder', 'qwen3.5', 'all')]
    [string]$LLM
)

# Helper function to check for and create a folder, then return its path
function Get-Or-Create-Folder {
    param([string]$FolderName)
    $fullPath = Join-Path -Path $TargetDirectory -ChildPath $FolderName
    if (-not (Test-Path -Path $fullPath)) {
        New-Item -ItemType Directory -Path $fullPath | Out-Null
    }
    return $fullPath
}

if ($LLM -eq 'all') {
    $cPath = Get-Or-Create-Folder "claude"
    $gPath = Get-Or-Create-Folder "gemini"
    $oPath = Get-Or-Create-Folder "codex"
    $pPath = Get-Or-Create-Folder "qwen3-coder"
    $qPath = Get-Or-Create-Folder "qwen3.5"

    # Build the Windows Terminal command to open multiple tabs in one window
    $wtArgs = "-d `"$cPath`" --suppressApplicationTitle --title `"✳ Claude`" pwsh -NoExit -Command `"claude`" `; " +
              "new-tab -d `"$gPath`" --suppressApplicationTitle --title `"◇ Gemini`" pwsh -NoExit -Command `"gemini`"`; " +
              "new-tab -d `"$oPath`" --suppressApplicationTitle --title `"O Codex`" pwsh -NoExit -Command `"codex`" `; " +
              "new-tab -d  `"$pPath`" --suppressApplicationTitle --title `"✳ Qwen 3 Coder`" pwsh -NoExit -Command `"ollama launch claude --model qwen3-coder-next:cloud`" `; " +
              "new-tab -d `"$qPath`" --suppressApplicationTitle --title `"✳ Qwen 3.5`" pwsh -NoExit -Command `"ollama launch claude --model qwen3.5:cloud`""
    
    Start-Process -FilePath "wt.exe" -ArgumentList $wtArgs
} else {
    $folderPath = Get-Or-Create-Folder $LLM
    
    $commandToRun = switch ($LLM) {
        'claude' { 'claude' }
        'gemini' { 'gemini' }
        'codex'  { 'codex' }
        'qwen3-coder' { 'ollama launch claude --model qwen3-coder-next:cloud' }
        'qwen3.5' { 'ollama launch claude --model qwen3.5:cloud' }
    }

    # Build the Windows Terminal command for a single tab
    $wtArgs = "-d `"$folderPath`" pwsh -NoExit -Command `"$commandToRun`""
    Start-Process -FilePath "wt.exe" -ArgumentList $wtArgs
}