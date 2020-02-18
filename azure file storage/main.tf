resource "azurerm_resource_group" "testrg" {
  name     = "infy-rcc"
  location = "westus"
}

resource "azurerm_storage_account" "testsa" {
  name                = "loansoverview"
  resource_group_name = azurerm_resource_group.testrg.name
  location            = azurerm_resource_group.testrg.location

  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "GRS"
}

module "staticweb" {
  source               = "StefanSchoof/static-website/azurerm"
  storage_account_name = azurerm_storage_account.testsa.name
}

data "azurerm_storage_account" "test" {
  name                = azurerm_storage_account.testsa.name
  resource_group_name = azurerm_resource_group.testrg.name

  depends_on = ["module.staticweb"]
}

output "static-web-url" {
  value = data.azurerm_storage_account.test.primary_web_endpoint
}

output "key" {
  value = data.azurerm_storage_account.test.primary_access_key
}