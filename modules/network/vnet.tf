module "avm-res-resources-resourcegroup" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  location            = var.region
  name                = var.resource_group_name
}

module "avm-res-network-virtualnetwork" {
  source = "Azure/avm-res-network-virtualnetwork/azurerm"

  address_space       = var.address_space
  location            = var.region
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  subnets             = var.subnets

  enable_telemetry    = false

  depends_on = [ module.avm-res-resources-resourcegroup ]
}
