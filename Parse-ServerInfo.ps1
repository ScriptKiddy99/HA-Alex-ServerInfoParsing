$Content = Get-Content -Path .\ServerInfo.txt -Raw

$RegexPater = [Regex]::new('(?<ServerInfo>(?<SiteCode>SiteCode\s?:\s?.+)(?:\n?\r?\t?\s?)(?<Ip>Ip\s?:\s?.+)(?:\n?\r?\t?\s?)(?<ComputerName>ComputerName\s?:\s?.+)(?:\n?\r?\t?\s?)(?<Manufacturer>Manufacturer\s?:\s?.+)(?:\n?\r?\t?\s?)(?<Model>Model\s?:\s?.+)(?:\n?\r?\t?\s?)(?<OS>OS\s?:\s?.+)(?:\n?)(?<OSArchitecture>OSArchitecture\s?:\s?.+)(?:\n?\r?\t?\s?)(?<OSInstallDate>OSInstallDate\s?:\s?.+)(?:\n?\r?\t?\s?)+(?<TimeZone>TimeZone\s?:\s+.+)(?:\n?\r?\t?\s?)+(?<Servicepack>Servicepack\s?:\s+.+)(?:\n?\r?\t?\s?)+(?<SerialNumber>SerialNumber\s?:\s+.+)(?:\n?\r?\t?\s?)+(?<CPU>CPU\s?:\s+.+)(?:\n?\r?\t?\s?)+(?<TotalRAM>TotalRAM\s?:\s+.+)(?:\n?\r?\t?\s?)+(?<DiskDriveModel>DiskDriveModel\s?:\s?.+)(?:\n?\r?\t?\s?)(?<HDDCapacity>HDDCapacity\s?:\s?.+)(?:\n?\r?\t?\s?)+?(?<HDDSpace>HDDSpace\s?:\s?.+)(?:\n?\r?\t?\s?)+(?<LastUser>LastUser\s?:\s?.+)(?:\n?\r?\t?\s?)+(?<LastReboot>LastReboot\s?:\s?.+)(?:\n?\r?\t?\s?)+(?<BiosData>BiosDate\s?:\s?.+)(?:\n?\r?\t?\s?)+(?<InvetoryDate>InventoryDate\s?:\s?.+))')
$Results = $RegexPater.Matches($Content)

$ServerObjects = @()
ForEach($Result in $Results)
{
    $ServerObject = [PSCustomObject]@{}

    $Result.Groups | ForEach-Object { if($_.Name -ne "0" -and $_.Name -ne "ServerInfo") {  Add-Member -MemberType NoteProperty -InputObject $ServerObject -Name $_.Name -Value $_.Value.Split(":")[1].Trim() } }

    $ServerObjects += $ServerObject
}


ForEach($Server in $ServerObjects)
{
    Write-Host "-------- Server $($Server.ComputerName) --------"
    Write-Host $Server.SiteCode
    Write-Host $Server.Ip
    Write-Host $Server.ComputerName
    Write-Host $Server.Manufacturer
    Write-Host $Server.Model
    Write-Host $Server.OS
    Write-Host $Server.OSArchitecture
    # etc.
}