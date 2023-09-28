output "public_ip" {
  value = data.azurerm_public_ip.tfeazytraining-pubip.ip_address
}

output "private_key" {
  value = tls_private_key.ssh.private_key_openssh
  sensitive=true
}

output "public_key" {
  value = tls_private_key.ssh.private_key_openssh
  sensitive=true
}
