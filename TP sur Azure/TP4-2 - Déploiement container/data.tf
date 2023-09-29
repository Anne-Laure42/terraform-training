data "azurerm_platform_image" "eazytraining-image" {
  location  = "france central"
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-focal"
  sku       = "20_04-lts"
}

data "azurerm_public_ip" "tfeazytraining-pubip" {
  name                = azurerm_public_ip.tfeazytraining-pubip.name
  resource_group_name = azurerm_resource_group.tfeazytraining-gp.name
}
