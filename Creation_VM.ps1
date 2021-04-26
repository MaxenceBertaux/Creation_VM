###########################Script de paramétrage de la VM####################################
$VMName = read-Host "Entrez le nom de la VM" 
[int64]$VMRAM = 1GB*(read-host "Entrez la mémoire vive que vous voulez") 
$VMGeneration = Read-Host "Entrez la generation, une ou deux"
$VMChemin = "C:\Hyper-V\$VMName\$VMName.vhdx"
[int64]$VMDD = 1GB*(Read-Host "Entrez la taille du disque dur virtuel")
#$VMISO = (Read-host "Entrez le type d'OS que vous voulez")

New-VM -Name $VMName -MemoryStartupBytes $VMRAM -Generation $VMGeneration -NewVHDPath $VMChemin -NewVHDSizeBytes $VMDD 
Set-VM -Name $VMName -AutomaticStartAction Start -CheckpointType Production 
Set-VMMemory -VMName $VMName -DynamicMemoryEnabled $false

########################Modification processeur virtuel#############################
$VMCPU = Read-Host ("Entrez le nombre de processeur")
Set-VMProcessor $VMName -Count $VMCPU -CompatibilityForMigrationEnabled $true -CompatibilityForOlderOperatingSystemsEnabled $true


#######################Ajout d'une remarque######################
$VMNote = Read-Host "Voulez-vous ajouter une remarque a la VM?"
if ( $VMNote -eq "oui" )
{$VMNote1 = read-host ("A vos remarques !")
Set-VM $VMName -Notes $VMNote1}
else
{Write-Host ("Pas de remarque") -ForegroundColor Red}


############################Démarrage de la VM###################
$VMStart = Read-Host "Voulez-vous démarrer la VM?" 
if ( $VMSTART -eq "oui")
{Start-VM $VMName 
Write-Host ("La machine $VMNAME est allumé") -ForegroundColor Green}
else 
{Write-Host ("La machine $VMName est éteinte") -ForegroundColor DarkRed}


