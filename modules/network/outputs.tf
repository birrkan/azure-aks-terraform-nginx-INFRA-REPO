output "resource_group_name" {
  value = module.avm-res-resources-resourcegroup.name
}

output "vnet_name" {
  value = module.avm-res-network-virtualnetwork.name
}

output "nsg_ids" {
  value = { for k, v in module.avm-res-network-networksecuritygroup : k => v.resource_id }
}

output "subnets" {
  value       = module.avm-res-network-virtualnetwork.subnets
}