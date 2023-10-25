resource "random_string" "storage_account" {
  length = 8
  upper = false
  numeric = true
  lower = true
  special = false
}


resource "azurerm_resource_group" "example" {
  name     = "${local.resource_name}-rg"
  location = var.location

   tags = local.required_tags
}

resource "azurerm_storage_account" "example" {
  name                     = "${random_string.storage_account.result}sto"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "my-blob-tfstate"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

resource "azurerm_mssql_server" "example" {
  name                          = "${local.resource_name}-mysqlserver"
  resource_group_name           = azurerm_resource_group.example.name
  location                      = azurerm_resource_group.example.location
  version                       = "12.0"
  administrator_login           = var.admin_username
  administrator_login_password  = var.admin_password
}

resource "azurerm_mssql_database" "example" {
  name           = var.sql_db_name
  server_id      = azurerm_mssql_server.example.id
 
  tags = local.required_tags
}
