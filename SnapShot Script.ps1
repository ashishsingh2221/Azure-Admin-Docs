Login-AzAccount

Select-AzSubscription -SubscriptionName Enterprise
$d = Get-Date -Format "MMddyyyyHHmm"


$testcsv = import-csv Login-AzureRmAccount
Select-AzSubscription -SubscriptionName Enterprise
$d = Get-Date -Format "MMddyyyyHHmm"


$testcsv = import-csv C:\Users\hw0556\Desktop\WVDSnapshots\Book3.csv
foreach($test in $testcsv)

{

$vm = $test.vmname

$a="-snap"
$post = $a + $d

$mdisks = Get-AzDisk
Foreach($mdisk in $mdisks)

{
if($mdisk.ManagedBy -ne $null)
{

$name = [string]($mdisk.ManagedBy)
$c=$name.Split("/")[-1]


if($c -eq $vm){
$infoDataDiskName = $mdisk.Name
$infodikuri = $mdisk.id
$SnapshotName = $infoDataDiskName+$post
$Location = $mdisk.Location
$ResourceGroupName = $mdisk.ResourceGroupName

$SnapshotConfig = New-AzSnapshotConfig -SourceUri $mdisk.Id -CreateOption Copy -Location $Location
$Snapshot=New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotName -ResourceGroupName $ResourceGroupName

Write-Host "Created Snapshot for VM:- " -ForegroundColor Pink -NoNewline; $vm;

}

}

}

} 