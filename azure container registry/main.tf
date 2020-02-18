resource "azurerm_resource_group" "rg" {
  name     = "infy-rcc-cr"
  location = "East US"
}

resource "azurerm_container_registry" "acr" {
  name                     = "infyrcccr"
  resource_group_name      = "${azurerm_resource_group.rg.name}"
  location                 = "${azurerm_resource_group.rg.location}"
  sku                      = "Standard"
  admin_enabled            = false
}