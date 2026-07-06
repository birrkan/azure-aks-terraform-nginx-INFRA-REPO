data "http" "my_ip" {
  url = "https://ifconfig.me/ip"
}

module "avm-res-network-networksecuritygroup" {
  for_each = var.security_groups
  source  = "Azure/avm-res-network-networksecuritygroup/azurerm"

  location            = var.region
  name                = each.value.name
  resource_group_name = module.avm-res-resources-resourcegroup.name

  enable_telemetry = false

  security_rules = {
    for rule_key, rule in each.value.security_rules : 
    rule_key => {
      name                       = rule.name
      priority                   = rule.priority
      direction                  = rule.direction
      access                     = rule.access
      protocol                   = rule.protocol
      source_port_range          = rule.source_port_range
      destination_port_range     = rule.destination_port_range
      source_address_prefix      = rule.source_address_prefix == "my_ip" ? trimspace(data.http.my_ip.body) : rule.source_address_prefix
      destination_address_prefix = rule.destination_address_prefix
    }
  }
}


resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  for_each = var.security_groups

  subnet_id                 = module.avm-res-network-virtualnetwork.subnets[each.key].resource_id
  network_security_group_id = module.avm-res-network-networksecuritygroup[each.key].resource_id

  depends_on = [module.avm-res-network-networksecuritygroup]
}
