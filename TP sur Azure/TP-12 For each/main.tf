resource "azurerm_resource_group" "example" {
  name     = "${local.resource_name}-rg"
  location = lookup(var.allowed_location,var.location, null)

   tags = local.required_tags
}

resource "azurerm_virtual_network" "example" {
  name                = "${local.resource_name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

   tags = local.required_tags
}

resource "azurerm_subnet" "example" {
  for_each             = local.subnets
  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = each.value.address_prefixes

}

resource "azurerm_network_security_group" "example" {
  for_each            = local.nsgs
  name                = each.value.name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
 
  tags = local.required_tags
}

resource "azurerm_subnet_network_security_group_association" "example" {
  for_each                  = azurerm_subnet.example
  subnet_id                 = each.value.id
  network_security_group_id = azurerm_network_security_group.example[lookup(local.subnets, each.value.name, null).nsg].id
}
