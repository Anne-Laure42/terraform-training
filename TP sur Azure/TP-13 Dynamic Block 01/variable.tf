locals {
  resource_name = "test"
  required_tags = "${var.project}"
}

variable "nsg_rules" {
    type = list(object({
      name                       = string
      priority                   = number
      source_port_range          = string
      destination_port_range     = string
  }))
  description = "The values for each NSG rule "
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
