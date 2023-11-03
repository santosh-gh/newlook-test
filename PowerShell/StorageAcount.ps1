$resourceGroup = "example-rg"
$location = "UK South"

New-AzResourceGroup -Name $resourceGroup -Location $location

$storageAccountName = "teststg890109"

New-AzStorageAccount -ResourceGroupName $resourceGroup `
  -Name $storageAccountName `
  -Location $location `
  -SkuName Standard_LRS `
  -Kind StorageV2 `
  -AllowBlobPublicAccess $true

# Create a context object using Azure AD credentials
$ctx = New-AzStorageContext -StorageAccountName $storageAccountName -UseConnectedAccount

$containerName = "tfstate"
New-AzStorageContainer -Name $containerName -Context $ctx