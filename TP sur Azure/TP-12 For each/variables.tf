locals {
  resource_name = "test"

  required_tags = "${var.project}"

  resourcegroup = "test-rg"

  nsgs = {
    nsg1 = {
      name   = "nsg1",
      subnet = "snet1"
    },
    nsg2 = {
      name   = "nsg2",
      subnet = "snet2"
    }
  }

  subnets = {
    snet1 = {
      name             = "snet1"
      nsg              = "nsg1"
      address_prefixes = ["10.0.0.0/26"]
    },
    snet2 = {
      name             = "snet2"
      nsg              = "nsg2"
      address_prefixes = ["10.0.0.64/26"]
    }

  }
}

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

variable "project" {
    type = map(string)
    description = "(optional) describe your variable"
    default = {
        environement = "test"
        project_name = "meta argument"
    }
}
