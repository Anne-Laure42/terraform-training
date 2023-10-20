output "location" {
    value = lookup(var.allowed_location,var.location, null)
}

output "resource_group_name" {
    value = azurerm_resource_group.rg.name
}
