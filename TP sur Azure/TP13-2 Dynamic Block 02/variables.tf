locals {
  resource_name = "test"
  required_tags = "${var.project}"
}

variable "nsg_rules" {
    type = map(object({
        port                   = number
        priority               = string
        protocol               = string
        destination_port_range = string
     }))

      default = {
        "http" = {
            port                   = 80
            priority               = "100"
            protocol               = "Tcp"
            destination_port_range = "80"
        },

        "ssh" = {
            port                   = 22
            priority               = "300"
            protocol               = "Tcp"
            destination_port_range = "22"
        },

        "https" = {
            port                   = 443
            priority               = "110"
            protocol               = "Tcp"
            destination_port_range = "443"
        }
      }

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
        project_name = "azure"
    }
}
