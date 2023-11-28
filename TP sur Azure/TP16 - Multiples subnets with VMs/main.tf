resource "azurerm_resource_group" "example" {
  name     = "${local.resource_name}-rg"
  location = lookup(var.allowed_location,var.location, null)

   tags = local.required_tags
}

resource "azurerm_virtual_network" "example" {
  name                = "${local.resource_name}-vnet"
  address_space       = ["10.0.0.0/24"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

   tags = local.required_tags
}

resource "azurerm_subnet" "example" {
  count                = 3
  name                = "${var.subnet_prefix}${count.index +1}"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = [cidrsubnet(var.cidr_blocks, 2, count.index)]
}

resource "azurerm_network_security_group" "example" {
  name                = "anne-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
 
  tags = local.required_tags

    security_rule {
       name = "http"
       priority = 100
       direction = "Inbound"
       access = "Allow"
       protocol = "Tcp"
       source_port_range = "*"
       destination_port_range = "80"
       source_address_prefix = "*"
       destination_address_prefix = "*"
   }

    security_rule {
       name = "ssh"
       priority = 300
       direction = "Inbound"
       access = "Allow"
       protocol = "Tcp"
       source_port_range = "*"
       destination_port_range = "22"
       source_address_prefix = "*"
       destination_address_prefix = "*"
   }

   security_rule {
       name = "icmp"
       priority = 120
       direction = "Inbound"
       access = "Allow"
       protocol = "Icmp"
       source_port_range = "*"
       destination_port_range = "*"
       source_address_prefix = "*"
       destination_address_prefix = "*"
   }
}

resource "azurerm_subnet_network_security_group_association" "example" {
  count                     = 3
  subnet_id                 = azurerm_subnet.example[count.index].id
  network_security_group_id = azurerm_network_security_group.example.id
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "example" {
  count               = var.vm_count
  name                = "${var.vm_name_prefix}${count.index +1}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.example[count.index].id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  tags = local.required_tags
}

resource "azurerm_public_ip" "example" {
  count               = var.vm_count
  name                = "${var.vm_name_prefix}${count.index +1}-pubip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Dynamic"
} 

resource "azurerm_network_interface" "example" {
  count               = var.vm_count
  name                = "${var.vm_name_prefix}${count.index +1}-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "ip"
    subnet_id                     = azurerm_subnet.example[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example[count.index].id
  }

  tags = local.required_tags
}
