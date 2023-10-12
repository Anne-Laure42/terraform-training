terraform {
    backend "azurerm" {
      resource_group_name  = "tfeazytraining-gp"
      storage_account_name = "tfstatepzcgbwu5"
      container_name       = "my-blob-tfstate"
      access_key           = "AHyGCVVEbMwS1TyQ/nL73FDWxNtB1VtEI6o1yWlQD3AdKIoaaheu/oKbvEDYs32RLTZy4RjGbpkV+AStttG8Ng=="
      key                  = "test/terraform.tfstate"
  }
}
