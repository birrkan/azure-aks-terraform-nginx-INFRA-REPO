variable "region" {
  type        = string
  description = "Location of the resource group."
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
