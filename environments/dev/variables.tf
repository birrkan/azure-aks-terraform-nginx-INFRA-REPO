variable "region" {
  type        = string
  description = "Location of the resource group."
}

variable "environment" {
  description = "The environment for tagging purposes (e.g., dev, prod)."
  type        = string
}

variable "vnet_name" {
  type        = string
  description = "vnet name"
}

variable "address_space" {
  type        = list(string)
}

variable "resource_group_name" {
  type        = string
  description = "resource group name"
}

variable "subnets" {
  description = "Map of subnets to create in the virtual network"
  type = map(object({
    name             = string
    address_prefixes = list(string)
    service_endpoints = set(string)
  }))
}


variable "security_groups" {
  description = "Map of security groups to create, each with its own security rules."
  type = map(object({
    name           = string
    security_rules = map(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
}


######################
#     STORAGE        #
######################

variable "storage_account_name" {
  description = "Name of the Azure Storage Account."
  type        = string
}

variable "tf_state_container_name" {
  description = "Name of the Blob Container to store Terraform state."
  type        = string
}

variable "shared_access_key_enabled" {
  description = "Enable shared key access for the Storage Account."
  type        = bool
  default     = true
}

# variable "key_vault_id" {
#   type = string
# }


###########
# KEY VAULT
###########

variable "keyvault_name" {
  description = "Name of the Azure Key Vault."
  type        = string
}

variable "sku_name" {
  type        = string
}


##########
# AKS
##########
variable "aks_resource_group_name" {
  type        = string
}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
}

variable "cluster_name" {
  type = string
}

variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. Set this value if you're running this example using Managed Identity as the authentication method."
  default     = null
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
}

variable "node_pool_name" {
  type = string
}

variable "node_pool_vm_size" {
  type = string
}

variable "min_node_count" {
  type = number
}

variable "max_node_count" {
  type = number
}

################
# ACR
###############
variable "acr_sku" {
  type = string
}

variable "acr_name" {
  type = string
}
