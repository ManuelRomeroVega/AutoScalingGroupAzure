$Thumbprint = "9E845CAE4987AA2A04FCF10F80416E966437112B"
$TenantId = "d2cc63fc-6c18-4213-bf42-f2001e89e788"
$ApplicationId = "44fc1beb-6709-4f7b-80e4-07e22e123ca7"

Connect-AzAccount -CertificateThumbprint $Thumbprint -ApplicationId $ApplicationId -Tenant $TenantId -ServicePrincipal

# Set variables
$resourceGroup = 'example-resources'
$vmName = 'example-machine'
$size = 'Standard_DS3_v2'
# Get the VM
$vm = Get-AzVM -ResourceGroupName $resourceGroup -Name $vmName
# Change the VM size
$vm.HardwareProfile.VmSize = $size
# Update the VM
Update-AzVM -ResourceGroupName $resourceGroup -VM $vm