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
  name                 = "${local.resource_name}-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "example" {
  name                = "${local.resource_name}-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
    
    dynamic "security_rule" {
      for_each = var.nsg_rules
      iterator = security_rule

      content{
         name = security_rule.key
         priority = security_rule.value["priority"]
         direction = "Inbound"
         access = "Allow"
         protocol = security_rule.value["protocol"]
         source_port_range = "*"
         destination_port_range = security_rule.value["destination_port_range"]
         source_address_prefix = "*"
         destination_address_prefix = "*"
      }
    }

  tags = local.required_tags
}
