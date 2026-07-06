variable "resource_group_location_aks" {
  type        = string
}

variable "aks_resource_group_name" {
  type        = string
}

variable "cluster_name" {
  type = string
}

variable "vnet_subnet_id" {
  type = string
}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
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
