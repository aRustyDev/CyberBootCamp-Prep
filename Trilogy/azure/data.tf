# data "azurerm_ssh_public_key" "example" {
#   name                = "existing"
#   resource_group_name = "existing"
# }

# data "azurerm_virtual_machine" "example" {
#   name                = "production"
#   resource_group_name = "networking"
# }

# data "azurerm_availability_set" "example" {
#   name                = "tf-appsecuritygroup"
#   resource_group_name = "my-resource-group"
# }

#  ssh ~/.ssh/id_rsa.pub RedAmin@52.255.204.99
#  ssh ~/.ssh/authorized_keys RedAmin@52.255.204.99