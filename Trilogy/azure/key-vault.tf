# data "azurerm_client_config" "current" {}

# resource "azurerm_key_vault" "RedTeam_Vault" {
#   name                              = "keyvault-test-build"
#   resource_group_name               = azurerm_resource_group.RedTeam_RG.name
#   location                          = azurerm_resource_group.RedTeam_RG.location
#   enabled_for_disk_encryption       = true
#   tenant_id                         = data.azurerm_client_config.current.tenant_id
#   purge_protection_enabled          = false
#   enabled_for_template_deployment   = true
#   enabled_for_deployment            = true

#   sku_name = "standard"

#   access_policy {
#     tenant_id = data.azurerm_client_config.current.tenant_id
#     object_id = data.azurerm_client_config.current.object_id

#     certificate_permissions = [
#       "create",
#       "delete",
#       "deleteissuers",
#       "get",
#       "getissuers",
#       "import",
#       "list",
#       "listissuers",
#       "managecontacts",
#       "manageissuers",
#       "setissuers",
#       "update",
#     ]

#     key_permissions = [
#       "backup",
#       "create",
#       "decrypt",
#       "delete",
#       "encrypt",
#       "get",
#       "import",
#       "list",
#       "purge",
#       "recover",
#       "restore",
#       "sign",
#       "unwrapKey",
#       "update",
#       "verify",
#       "wrapKey",
#     ]

#     secret_permissions = [
#       "backup",
#       "delete",
#       "get",
#       "list",
#       "purge",
#       "recover",
#       "restore",
#       "set",
#     ]

#     storage_permissions = [
#       "get",
#     ]
#   }

#   network_acls {
#     default_action = "Allow"
#     bypass         = "AzureServices"
#   }
# }

# resource "azurerm_key_vault_secret" "test_build" {
#   name         = "prikey-test-build"
#   value        = base64encode(file("C:/users/aRustyDev.ARUSTY/.ssh/id_rsa.pub"))
#   key_vault_id = azurerm_key_vault.RedTeam_Vault.id
# }

# resource "azurerm_key_vault_key" "generated" {
#   name         = "generated-certificate"
#   key_vault_id = azurerm_key_vault.RedTeam_Vault.id
#   key_type     = "RSA"
#   key_size     = 4096

#   key_opts = [
#     "decrypt",
#     "encrypt",
#     "sign",
#     "unwrapKey",
#     "verify",
#     "wrapKey",
#   ]
# }