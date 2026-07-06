#https://learn.microsoft.com/en-us/azure/container-registry/container-registry-get-started-terraform?tabs=azure-cli

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.acr_resource_group_name
  location            = var.location
  sku                 = var.acr_sku
}
