# Push J2ME games straight into the WP8.0 app's library over USB (ISETool, SDK 8.1).
#   push_wp80_game.cmd game1.jar [game2.jar ...]
# Phone: unlocked screen, J2ME app CLOSED. Takes a snapshot of the app's IsolatedStorage,
# adds games\<id>\game.jar + info.txt (+ game.jad if a .jad with the same name exists)
# and writes the whole snapshot back. Existing games with the same id are replaced.
param([Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)][string[]]$Jars)

$ErrorActionPreference = 'Stop'
$ProductId = '{3D8F1A62-7C4B-4E95-A1D0-5B2E9F6C7A80}'
$IseTool = "${env:ProgramFiles(x86)}\Microsoft SDKs\Windows Phone\v8.1\Tools\IsolatedStorageExplorerTool\ISETool.exe"
if (-not (Test-Path $IseTool)) { throw "ISETool (SDK 8.1) not found: $IseTool" }
Add-Type -AssemblyName System.IO.Compression.FileSystem

function Read-Manifest([string]$jar) {
    $zip = [System.IO.Compression.ZipFile]::OpenRead($jar)
    try {
        $e = $zip.Entries | Where-Object { $_.FullName -ieq 'META-INF/MANIFEST.MF' } | Select-Object -First 1
        if (-not $e) { return @{} }
        $r = New-Object System.IO.StreamReader($e.Open())
        $text = $r.ReadToEnd(); $r.Close()
    } finally { $zip.Dispose() }
    $m = @{}; $last = $null
    foreach ($line in ($text -split "`r?`n")) {
        if ($line.StartsWith(' ') -and $last) { $m[$last] += $line.Substring(1); continue }
        $i = $line.IndexOf(':')
        if ($i -gt 0) { $last = $line.Substring(0, $i).Trim(); $m[$last] = $line.Substring($i + 1).Trim() }
    }
    return $m
}

# same rule as game_library: ASCII only (accents dropped, others -> _)
function To-Id([string]$s) {
    $d = $s.Normalize([Text.NormalizationForm]::FormD) -replace '[\u0300-\u036f]', ''
    $d = $d -replace '[\u0111\u0110]', 'd'
    $d = ($d -replace '[^A-Za-z0-9 ._-]', '_').Trim()
    if (-not $d) { $d = 'game' }
    return $d
}

function Run-IseTool([string[]]$a) {
    $out = & $IseTool @a 2>&1 | Out-String
    if ($out -notmatch 'Done') { throw "ISETool $($a[0]) failed:`n$out`nPhone unlocked? App closed? USB connected?" }
}

$snap = Join-Path $env:TEMP ("j2mewp_push_" + [Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory $snap | Out-Null
try {
    Write-Host 'Reading the app storage from the phone...'
    Run-IseTool @('ts', 'de', $ProductId, $snap)
    $store = Join-Path $snap 'IsolatedStore'
    $games = Join-Path $store 'games'
    New-Item -ItemType Directory -Force $games | Out-Null

    foreach ($jarArg in $Jars) {
        $jar = (Resolve-Path $jarArg).Path
        $m = Read-Manifest $jar
        $midlet1 = $m['MIDlet-1']
        if (-not $midlet1) { Write-Warning "$jar : no MIDlet-1 in the manifest, skipped"; continue }
        $parts = $midlet1.Split(',')
        $class = $parts[$parts.Length - 1].Trim()
        $name = if ($m['MIDlet-Name']) { $m['MIDlet-Name'] } else { [IO.Path]::GetFileNameWithoutExtension($jar) }
        $id = To-Id $name
        $dir = Join-Path $games $id
        if (Test-Path $dir) { Remove-Item -Recurse -Force $dir }
        New-Item -ItemType Directory $dir | Out-Null
        Copy-Item $jar (Join-Path $dir 'game.jar')
        $jad = [IO.Path]::ChangeExtension($jar, '.jad')
        if (Test-Path $jad) { Copy-Item $jad (Join-Path $dir 'game.jad') }
        $info = "added=$([DateTime]::UtcNow.ToFileTimeUtc())`nclass=$class`nname=$name`nvendor=$($m['MIDlet-Vendor'])`nversion=$($m['MIDlet-Version'])`n"
        [IO.File]::WriteAllText((Join-Path $dir 'info.txt'), $info, (New-Object Text.UTF8Encoding($false)))
        Write-Host "  + $id  ($class)"
    }

    Write-Host 'Writing the app storage back to the phone...'
    Run-IseTool @('rs', 'de', $ProductId, $store)
    Write-Host 'Done. Open the app: the games are in the list.'
} finally {
    Remove-Item -Recurse -Force $snap -ErrorAction SilentlyContinue
}
