output "resource_group_name" {
  value = azurerm_resource_group.example.name
}

output "admin_password" {
  sensitive = true
  value     = var.admin_password
}

output "sql_server_name" {
  sensitive = true
  value = azurerm_mssql_server.example.name
}
