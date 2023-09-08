data "azurerm_platform_image" "eazytraining-image" {
  location  = "france central"
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-focal"
  sku       = "20_04-lts"
}
