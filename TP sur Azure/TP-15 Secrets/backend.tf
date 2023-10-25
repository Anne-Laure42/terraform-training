terraform {
    backend "azurerm" {
      resource_group_name  = "test-rg"
      storage_account_name = "dswqgqp3sto"
      container_name       = "my-blob-tfstate"
      key                  = "terraform.tfstate"
  }
}
