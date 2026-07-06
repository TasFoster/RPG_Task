# Авто-коммит и авто-пуш изменений проекта (вызывается Stop-hook Claude Code).
# Коммитит только при наличии изменений; ошибки пуша не прерывают работу.
$ErrorActionPreference = 'SilentlyContinue'
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')

Set-Location -Path $PSScriptRoot\..

$changes = git status --porcelain
if ([string]::IsNullOrWhiteSpace($changes)) {
  # Нет изменений — но всё равно попробуем протолкнуть неотправленные коммиты.
  $unpushed = git log '@{u}..HEAD' --oneline 2>$null
  if (-not [string]::IsNullOrWhiteSpace($unpushed)) { git push origin main 2>&1 | Out-Null }
  exit 0
}

$stamp = Get-Date -Format 'yyyy-MM-dd HH:mm'
git add -A
git commit -m "auto: рабочие изменения ($stamp)" | Out-Null
git push origin main 2>&1 | Out-Null
