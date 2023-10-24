nsg_rules = [ {
    
    name                       = "http"
    priority                   = 100
    source_port_range          = "*"
    destination_port_range     = "80"

  
  },
  {
    name                       = "ssh"
    priority                   = 300
    source_port_range          = "*"
    destination_port_range     = "22"
  },
  {
    name                       = "https"
    priority                   = 110
    source_port_range          = "*"
    destination_port_range     = "443"
  }
]
