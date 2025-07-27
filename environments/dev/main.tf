module "network" {
  source = "../../modules/network"

  region                     = var.region
  resource_group_name        = var.resource_group_name
  vnet_name                  = var.vnet_name
  address_space              = var.address_space
  subnets                    = var.subnets
  security_groups            = var.security_groups
}

module "aks" {
  source = "../../modules/compute"

  resource_group_location_aks = var.region
  vnet_subnet_id = module.network.subnets["subnet1"].resource_id
  aks_resource_group_name = var.aks_resource_group_name
  cluster_name = var.cluster_name
  node_count = var.node_count
  msi_id = var.msi_id
  username = var.username
  node_pool_name = var.node_pool_name
  node_pool_vm_size = var.node_pool_vm_size
  min_node_count = var.min_node_count
  max_node_count = var.max_node_count
}

module "acr" {
  source = "../../modules/acr"

  location = var.region
  acr_resource_group_name = module.aks.aks_resource_group_name
  acr_name = var.acr_name
  acr_sku = var.acr_sku
}
