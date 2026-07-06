# # NETWORK OUTPUTS

# output "resource_group_name" {
#   value = module.network.resource_group_name
# }

# output "vnet_name" {
#   value = module.network.vnet_name
# }


# output "nsg_ids" {
#   value = module.network.nsg_ids
# }

# output "subnets" {
#   value = module.network.subnets
# }


# # STORAGE OUTPUTS

# output "storage_account_name" {
#   description = "Name of the created Azure Storage Account."
#   value       = module.storage.storage_account_name
# }

# output "storage_account_id" {
#   description = "ID of the created Azure Storage Account."
#   value       = module.storage.storage_account_id
# }

# # output "tf_state_container_name" {
# #   description = "Name of the Blob Container for Terraform state."
# #   value       = module.storage_account.containers.tfstate.name
# # }

# output "tf_state_container_id" {
#   description = "ID of the Blob Container for Terraform state."
#   value       = module.storage.tf_state_container_id
# }

# # output "resource_details_of_storage_account" {
# #   value = module.storage.resource_details_of_storage_account
# #   sensitive = false
# # }


# # output "keyvault_id" {
# #   description = "The ID of the Azure Key Vault."
# #   value       = module.keyvault.keyvault_id
# # }

# # output "keyvault_uri" {
# #   description = "The URI of the Azure Key Vault."
# #   value       = module.keyvault.keyvault_uri
# # }
