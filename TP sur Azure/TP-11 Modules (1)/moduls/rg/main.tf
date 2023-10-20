variable "location" {
    type = string
    description = "Location of the resource group"
    default = "fr"
}

variable "allowed_location" {
    type = map
    description = "Location allowed for the rg"
    default = {
        fr = "france central"
        neu = "north europe"
    }
}

variable "project_name" {
    type = string
    description = "name of the project"
    default = "modules"
}

variable "environment" {
    type = string
    description = "test"
}


locals {
    resource_name = "test_module"
    required_tags = {
        project     = var.project_name
        environment = var.environment
  }
}


# Create a Resource Group

resource "azurerm_resource_group" "rg" {
  name     = "${local.resource_name}-rg"
  location = lookup(var.allowed_location,var.location, null)
  
  tags = local.required_tags
}
