terraform {
    backend "azurerm" {
      resource_group_name  =  var.resource_group_name
      storage_account_name = "tfstate<RANDOM_STRING>"
      container_name       = "my-blob-tfstate"
      key                  = "terraform.tfstate"
  }
}
