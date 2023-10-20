module "rg" {
   source = "./modules/rg"

    environment = var.environment
}


#module "storageaccount" {
#    source = "./modules/storageaccount"
#
#    environment = var.environment
#    resource_group_name = var.resource_group_name
#    name = module.storageaccount.name 
#    location = var.location
#    account_tier = var.account_tier
#    account_kind = var.account_kind
#    replication_type = var.replication_type  
#}
