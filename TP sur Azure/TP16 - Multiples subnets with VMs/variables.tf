locals {
  resource_name = "anne-testlab"

  required_tags = "${var.project}"
}

variable "cidr_blocks" {
  default = "10.0.0.0/24"
}

variable "subnet_prefix" {
    type = string
    description = "(optional) describe your variable"
    default = "subnet-"
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
        environment = "lab"
        project_name = "subnets&vms"
    }
}

variable "vm_count" {
    type = string
    description = "(optional) describe your variable"
    default = 3
}

variable "vm_name_prefix" {
    type = string
    description = "(optional) describe your variable"
    default = "vm-"
}
