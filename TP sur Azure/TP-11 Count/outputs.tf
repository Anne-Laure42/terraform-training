output "all_nic_id" {
  value = azurerm_network_interface.example[*].id
}

output "one_nic_id" {
  value = azurerm_network_interface.example[1].id
}
