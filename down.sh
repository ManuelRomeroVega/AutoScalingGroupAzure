$Thumbprint = ""
$TenantId = ""
$ApplicationId = ""

Connect-AzAccount -CertificateThumbprint $Thumbprint -ApplicationId $ApplicationId -Tenant $TenantId -ServicePrincipal

# Set variables
$resourceGroup = 'example-resources'
$vmName = 'example-machine'
$size = 'Standard_F2'
# Get the VM
$vm = Get-AzVM -ResourceGroupName $resourceGroup -Name $vmName
# Change the VM size
$vm.HardwareProfile.VmSize = $size
# Update the VM

Update-AzVM -ResourceGroupName $resourceGroup -VM $vm
