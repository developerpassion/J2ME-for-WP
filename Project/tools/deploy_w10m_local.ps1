# Deploy the built W10M app to this PC (like VS "Deploy" for Local Machine) and optionally run it.
#   powershell -File deploy_w10m_local.ps1 [-Config Debug] [-Platform Win32] [-Autorun "Assets\test\hello.jar|Hello"] [-Run] [-Wait 6]
# Builds a loose-file layout from the .appxrecipe produced by MSBuild, registers it,
# writes LocalState\autorun.txt and prints LocalState\j2me.log.
param(
    [string]$Config = 'Debug',
    [string]$Platform = 'Win32',
    [string]$Autorun = '',
    [switch]$Run,
    [int]$Wait = 6,
    [string]$Jar = ''
)
$ErrorActionPreference = 'Stop'
$root = Resolve-Path (Join-Path $PSScriptRoot '..\W10M')
$bin = Join-Path $root "bin\$Platform\$Config\J2MEW10M"
$recipe = Join-Path $bin 'J2MEW10M.build.appxrecipe'
$layout = Join-Path $root "bin\$Platform\$Config\AppX"

Get-Process J2MEW10M -ErrorAction SilentlyContinue | Stop-Process -Force
if (Test-Path $layout) { Remove-Item -Recurse -Force $layout }
New-Item -ItemType Directory -Force $layout | Out-Null

[xml]$x = Get-Content $recipe
$ns = @{ m = 'http://schemas.microsoft.com/developer/msbuild/2003' }
$items = @()
$items += Select-Xml -Xml $x -XPath '//m:AppXManifest' -Namespace $ns
$items += Select-Xml -Xml $x -XPath '//m:AppxPackagedFile' -Namespace $ns
foreach ($i in $items) {
    $src = [Uri]::UnescapeDataString($i.Node.Include)
    $dst = Join-Path $layout $i.Node.PackagePath
    New-Item -ItemType Directory -Force (Split-Path $dst) | Out-Null
    Copy-Item $src $dst -Force
}
Write-Host "layout: $layout ($($items.Count) files)"

$old = Get-AppxPackage J2MEWP.W10M
if ($old -and ($old.InstallLocation -ne $layout.ToString())) {
    # Same version registered from another folder: re-register would keep the old location.
    # Note: removing the package also wipes its LocalState.
    Remove-AppxPackage $old.PackageFullName
}
Add-AppxPackage -Register (Join-Path $layout 'AppxManifest.xml') -ForceApplicationShutdown
$pkg = Get-AppxPackage J2MEWP.W10M
$ls = Join-Path $env:LOCALAPPDATA "Packages\$($pkg.PackageFamilyName)\LocalState"
New-Item -ItemType Directory -Force $ls | Out-Null
if ($Jar) {
    New-Item -ItemType Directory -Force (Join-Path $ls 'games') | Out-Null
    Copy-Item $Jar (Join-Path $ls 'games') -Force
}
if ($Autorun) { Set-Content -Encoding ascii (Join-Path $ls 'autorun.txt') $Autorun }
elseif (Test-Path (Join-Path $ls 'autorun.txt')) { Remove-Item (Join-Path $ls 'autorun.txt') }

if ($Run) {
    Remove-Item (Join-Path $ls 'j2me.log') -ErrorAction SilentlyContinue
    Start-Process "shell:AppsFolder\$($pkg.PackageFamilyName)!App"
    Start-Sleep $Wait
    Get-Content (Join-Path $ls 'j2me.log') -ErrorAction SilentlyContinue
}
