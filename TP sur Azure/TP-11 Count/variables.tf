#variable "vm_names" {
#    type = list
#    description = "(optional) describe your variable"
#    default = ["vm1", "vm2", "vm3"]
#}

variable "vm_name_prefix" {
    type = string
    description = "(optional) describe your variable"
    default = "test-vm-"
}

variable "vm_count" {
    type = string
    description = "(optional) describe your variable"
    default = 3
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
