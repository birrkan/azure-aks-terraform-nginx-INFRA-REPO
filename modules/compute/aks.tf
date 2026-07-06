resource "azurerm_resource_group" "rg" {
location = var.resource_group_location_aks
name = var.aks_resource_group_name
}

resource "random_pet" "azurerm_kubernetes_cluster_dns_prefix" {
  prefix = "dns"
}

resource "azurerm_kubernetes_cluster" "k8s" {
  location            = azurerm_resource_group.rg.location
  name                = var.cluster_name
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = random_pet.azurerm_kubernetes_cluster_dns_prefix.id

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = var.node_pool_name
    vm_size    = var.node_pool_vm_size
    node_count = var.node_count
    
    vnet_subnet_id = var.vnet_subnet_id
    
    auto_scaling_enabled = true
    min_count  = var.min_node_count  
    max_count  = var.max_node_count

    temporary_name_for_rotation = "tempnpool"
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"  
    service_cidr      = "10.0.2.0/24"
    dns_service_ip = "10.0.2.10"
  }
}
