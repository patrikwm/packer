Param(
  [string]$VM_NAME,
  [string]$VSPHERE_SERVER,
  [string]$VSPHERE_PASSWORD,
  [string]$VSPHERE_USER
)

# Ensure the build fails if there is a problem.
# The build will fail if there are any errors on the remote machine too!
$ErrorActionPreference = 'Stop'

# Load PowerCLI to current session
Get-Module -ListAvailable PowerCLI* | Import-Module

# Connect to vSphere vCenter
Connect-VIServer -Server $VSPHERE_SERVER -User $VSPHERE_USER -Password $VSPHERE_PASSWORD

# Check if template already exists
$TEMPLATE = Get-template -name $VM_NAME -ErrorAction SilentlyContinue
if ($TEMPLATE){
   Remove-Template -Template $TEMPLATE -Confirm:$false
}

$network = Get-VM $VM_NAME | Get-NetworkAdapter | select -ExpandProperty "NetworkName"
Get-VM $VM_NAME | get-networkAdapter | Where { $_.Type -eq "E1000"} | set-NetworkAdapter -Type "vmxnet3" -NetworkName $network -Confirm:$false

# Convert VM to template
Get-VM $VM_NAME | Set-VM -ToTemplate -Name $VM_NAME -Confirm:$false
