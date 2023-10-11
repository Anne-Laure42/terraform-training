# Create a ramdom string for the Storage Account
resource "random_string" "storage_account" {
  length = 8
  upper = false
  number = true
  lower = true
  special = false
}

# Create a Resource Group
resource "azurerm_resource_group" "tfeazytraining-gp" {
  name     = var.resource_group_name
  location = var.location
}

# Create a Virtual Network
resource "azurerm_virtual_network" "tfeazytraining-vnet" {
  name                = "my-eazytraining-vnet"
  location            = azurerm_resource_group.tfeazytraining-gp.location
  resource_group_name = azurerm_resource_group.tfeazytraining-gp.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "nginx-server"
  }
}

# Create a Subnet in the Virtual Network
resource "azurerm_subnet" "tfeazytraining-subnet" {
  name                 = "my-eazytraining-subnet"
  resource_group_name  = azurerm_resource_group.tfeazytraining-gp.name
  virtual_network_name = azurerm_virtual_network.tfeazytraining-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create a Network Security Group and rule
resource "azurerm_network_security_group" "tfeazytraining-nsg" {
  name                = "my-eazytraining-nsg"
  location            = azurerm_resource_group.tfeazytraining-gp.location
  resource_group_name = azurerm_resource_group.tfeazytraining-gp.name
 
 
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

  tags = {
    environment = "nginx-server"
  }
}

# Create public IPs
resource "azurerm_public_ip" "tfeazytraining-pubip" {
  name                = "my-eazytraining-pubip"
  location            = azurerm_resource_group.tfeazytraining-gp.location
  resource_group_name = azurerm_resource_group.tfeazytraining-gp.name
  allocation_method   = "Dynamic"
}

# Create a Network Interface
resource "azurerm_network_interface" "tfeazytraining-vnic" {
  name                = "my-eazytraining-nic"
  location            = azurerm_resource_group.tfeazytraining-gp.location
  resource_group_name = azurerm_resource_group.tfeazytraining-gp.name

  ip_configuration {
    name                          = "my-eazytraining-nic-ip"
    subnet_id                     = azurerm_subnet.tfeazytraining-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.tfeazytraining-pubip.id
  }
  tags = {
    environment = "nginx-server"
  }
}

# Create a Network Interface Security Group association
resource "azurerm_network_interface_security_group_association" "tfeazytraining-assoc" {
  network_interface_id      = azurerm_network_interface.tfeazytraining-vnic.id
  network_security_group_id = azurerm_network_security_group.tfeazytraining-nsg.id
}

# Generate SSH key
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create a Virtual Machine
resource "azurerm_linux_virtual_machine" "tfeazytraining-nginxserver" {
  name                            = "my-eazytraining-nginxserver"
  location                        = azurerm_resource_group.tfeazytraining-gp.location
  resource_group_name             = azurerm_resource_group.tfeazytraining-gp.name
  network_interface_ids           = [azurerm_network_interface.tfeazytraining-vnic.id]
  size                            = var.instance_type
  computer_name                   = "myvm"
  admin_username                  = var.TF_VAR_admin_username
  admin_password                  = var.TF_VAR_admin_password
  disable_password_authentication = true

  custom_data = filebase64("customdata.sh")

  admin_ssh_key {
   username = "azureuser"
   public_key = file("~/.ssh/id_rsa.pub")
  }

  source_image_reference {
    publisher = data.azurerm_platform_image.eazytraining-image.publisher
    offer     = data.azurerm_platform_image.eazytraining-image.offer
    sku       = data.azurerm_platform_image.eazytraining-image.sku
    version   = "latest"
  }
  
  os_disk {
    name                 = "my-eazytraining-os-disk"
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
	
  tags = {
    environment = "nginx-server"
  }

  connection {
        host = azurerm_linux_virtual_machine.tfeazytraining-nginxserver.public_ip_address
        user = var.TF_VAR_admin_username
        password = var.TF_VAR_admin_password
        type = "ssh"
        private_key = "${file("~/.ssh/id_rsa")}"
        timeout = "1m"
    }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
  }

  provisioner "local-exec" {
    command = "echo ${azurerm_linux_virtual_machine.tfeazytraining-nginxserver.public_ip_address} >> public_ip_address.txt"
  } 
}

# Create a Storage account
resource "azurerm_storage_account" "storage-account-azure-anne-eazytraining" {
  name                     = "tfstate${random_string.storage_account.result}"
  location                 = azurerm_resource_group.tfeazytraining-gp.location
  resource_group_name      = azurerm_resource_group.tfeazytraining-gp.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "nginx-server"
  }
}

# Create a Blob container
resource "azurerm_storage_container" "tfstate" {
  name                  = "my-blob-tfstate"
  storage_account_name  = azurerm_storage_account.storage-account-azure-anne-eazytraining.name
  container_access_type = "private"
 }
