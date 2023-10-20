Créez une infrastrastrure en utilisant le meta argument "Count"

L'infra sera la suivante :

- 1 Resource Group
- 1 Vnet
- 1 Subnet
- 3 Vms
- 3 NIC
- 3 IP Publiques


Autre possibilité pour créer 3 VMs :

Fichier variables.tf

variable "vm_names" {
    type = list
    description = "(optional) describe your variable"
    default = ["vm1", "vm2", "vm3"]
}

Fichier Main.tf

resource "azurerm_linux_virtual_machine" "example" {
  count               = lenght(var.vm_names)
  name                = var.vm_names[count.index +1]

