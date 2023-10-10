variable "instance_type" {
   description = "size of the vm"
   default = "Standard_D2_v2"
}

variable "location" {
    description = "location of the vm"
    default = "france central"
}

variable "resource_group_name" {
    description = "name of the resource group"
    default = "tfeazytraining-gp"
  
}

variable "TF_VAR_admin_username" {
    description = "username of the vm"
    type = string
    sensitive = true
}

variable "TF_VAR_admin_password" {
    description = "password of the vm"
    type = string
    sensitive = true
}
