region                    = "East US"
environment = "dev"
resource_group_name = "devops_project"
vnet_name = "devVnet"
address_space = ["10.0.0.0/16"]

subnets = {
  subnet1 = {
    name             = "subnet1"
    address_prefixes = ["10.0.0.0/24"]
    service_endpoints = ["Microsoft.KeyVault"]
  }
  subnet2 = {
    name             = "subnet2"
    address_prefixes = ["10.0.1.0/24"]
    service_endpoints = ["Microsoft.KeyVault"]
  }
}


security_groups = {
  subnet1 = {
    name = "subnet1-sg"
    security_rules = {
      AllowSSH = {
        name                       = "AllowSSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "my_ip"
        destination_address_prefix = "*"
      }
      AllowHTTP = {
        name                       = "AllowHTTP"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }
  subnet2 = {
    name = "subnet2-sg"
    security_rules = {
      AllowHTTPS = {
        name                       = "AllowHTTPS"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }
}

storage_account_name = "birkandevopsdev"
tf_state_container_name = "tfstate"
shared_access_key_enabled = true

keyvault_name = "keyvault-birkan"
sku_name = "standard"


# aks
aks_resource_group_name = "aks_rg_birkan"
cluster_name = "clusterbirkan"
node_count = 1
msi_id = null
username = "aks_cluster_birkan"
node_pool_name = "nodepool"
node_pool_vm_size = "Standard_B2s"
min_node_count = 1
max_node_count = 2

#acr
acr_name = "devacrbirkan"
acr_sku = "Standard"
