<#
.SYNOPSIS
  Download the real mobile app-usage datasets into data/raw/ (gitignored).

.EXAMPLE
  # everything (Carat is ~6.4 GB, run it last / in the background)
  powershell -ExecutionPolicy Bypass -File scripts\download_datasets.ps1

  # only some datasets
  powershell -ExecutionPolicy Bypass -File scripts\download_datasets.ps1 -Only lsapp,tsinghua,telefonica

  # Carat in the background (resumable; re-run the same command to resume)
  Start-Process powershell -ArgumentList '-ExecutionPolicy Bypass -File scripts\download_datasets.ps1 -Only carat' -WindowStyle Minimized

.NOTES
  Uses curl.exe (ships with Windows 10+) with -C - so interrupted downloads resume.
  DiversityOne is request-only and is NOT downloaded; see data/raw/diversityone/README.md.
  By downloading you accept each dataset's terms (see README.md > Datasets): research use only, cite the papers.
#>
param(
    [string[]]$Only = @('telefonica', 'lsapp', 'tsinghua', 'carat')
)

$ErrorActionPreference = 'Stop'
# allow "-Only a,b" when invoked via -File (arrives as one comma-joined string)
$Only = @($Only | ForEach-Object { $_ -split ',' } | ForEach-Object { $_.Trim().ToLower() } | Where-Object { $_ })
$Root = Split-Path -Parent $PSScriptRoot
$Raw  = Join-Path $Root 'data\raw'

function Get-File([string]$Url, [string]$Dest, [long]$ExpectedBytes = 0) {
    $dir = Split-Path -Parent $Dest
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
    if ((Test-Path $Dest) -and $ExpectedBytes -gt 0 -and (Get-Item $Dest).Length -eq $ExpectedBytes) {
        Write-Host "OK (already downloaded): $Dest"
        return
    }
    Write-Host "Downloading $Url -> $Dest"
    # PS 5 turns native stderr into errors when redirected; relax EAP just for curl
    $prev = $ErrorActionPreference; $ErrorActionPreference = 'Continue'
    & curl.exe -sS -L --fail --retry 5 --retry-delay 10 -C - -o $Dest $Url
    $code = $LASTEXITCODE; $ErrorActionPreference = $prev
    if ($code -ne 0) { throw "curl failed ($code) for $Url" }
    $size = (Get-Item $Dest).Length
    if ($ExpectedBytes -gt 0 -and $size -ne $ExpectedBytes) {
        throw "Size mismatch for ${Dest}: got $size, expected $ExpectedBytes"
    }
    Write-Host "Done: $Dest ($size bytes)"
}

# 1. Mobile Phone Use Dataset (Pielot et al., UbiComp'17) - Google Drive, ~310 MB zip
if ($Only -contains 'telefonica') {
    $id = '1tQA1jKm1qHIuwO-llNHSjwJrRc4teyI2'
    Get-File "https://drive.usercontent.google.com/download?id=$id&export=download&confirm=t" `
             (Join-Path $Raw 'telefonica_mobile_phone_use\mpud.zip') 310938979
}

# 2. LSApp (Aliannejadi et al., TOIS 2021) - the .tsv.gz is actually a tar.gz containing lsapp.tsv
if ($Only -contains 'lsapp') {
    $dest = Join-Path $Raw 'lsapp\lsapp.tsv.gz'
    Get-File 'https://github.com/aliannejadi/LSApp/raw/main/lsapp.tsv.gz' $dest 7329439
    Push-Location (Split-Path -Parent $dest)
    try { & tar.exe -xzf 'lsapp.tsv.gz'; if ($LASTEXITCODE -ne 0) { throw 'tar extraction failed' } }  # yields lsapp.tsv
    finally { Pop-Location }
}

# 3. Tsinghua App Usage Dataset (Yu et al., IMWUT 2018) - RAR archives
if ($Only -contains 'tsinghua') {
    $base = 'https://fi.ee.tsinghua.edu.cn/appusage'
    $dir  = Join-Path $Raw 'tsinghua_app_usage'
    Get-File "$base/App_usage_trace.rar" (Join-Path $dir 'App_usage_trace.rar') 25363073
    foreach ($f in 'App2Category.rar', 'Categorys.rar', 'base_poi.rar') { Get-File "$base/$f" (Join-Path $dir $f) }
    $7z = 'C:\Program Files\7-Zip\7z.exe'
    if (Test-Path $7z) { Get-ChildItem $dir -Filter *.rar | ForEach-Object { & $7z x -y "-o$dir" $_.FullName | Out-Null } }
    else { Write-Host 'Note: 7-Zip not found; .rar files left unextracted.' }
}

# 4. Carat Top 1000 Users (Univ. of Helsinki) - ~6.4 GB password-protected zip
#    Password is published on https://www.cs.helsinki.fi/group/carat/data-sharing/ (see README.md > Datasets)
if ($Only -contains 'carat') {
    Get-File 'https://www.cs.helsinki.fi/group/carat/data-sharing/carat-data-top1k-users-2014-to-2018-08-25.zip' `
             (Join-Path $Raw 'carat_top1000\carat-data-top1k-users-2014-to-2018-08-25.zip') 6375824106
}

Write-Host 'Finished. DiversityOne must be requested manually: data/raw/diversityone/README.md'
