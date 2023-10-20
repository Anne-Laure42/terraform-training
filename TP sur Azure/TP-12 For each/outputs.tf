output "subnets_name" {
    value = [for subnets in azurerm_subnet.example : subnets.name ]
}

output "nsg_names" {
    value = [for nsgs in azurerm_network_security_group.example : nsgs.name ]
}
