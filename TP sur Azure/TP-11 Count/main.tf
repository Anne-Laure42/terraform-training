resource "azurerm_resource_group" "example" {
  name     = "${local.resource_name}-rg"
  location = lookup(var.allowed_location,var.location, null)

   tags = local.required_tags
}

resource "azurerm_virtual_network" "example" {
  name                = "${local.resource_name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

   tags = local.required_tags
}

resource "azurerm_subnet" "example" {
  name                 = "${local.resource_name}-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "example" {
  count               = var.vm_count
  name                = "${var.vm_name_prefix}${count.index +1}-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
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
