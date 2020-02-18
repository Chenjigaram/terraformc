resource "azurerm_resource_group" "test" {
  name     = "infy-rcc-kub"
  location = "East US"
}
	

resource "azurerm_kubernetes_cluster" "test" {
  name                = "rcc"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  dns_prefix          = "acctestagent1"

  agent_pool_profile {
    name            = "default"
    count           = 1
    vm_size         = "Standard_D1_v2"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  agent_pool_profile {
    name            = "pool2"
    count           = 1
    vm_size         = "Standard_D2_v2"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = "d7a1b8a5-6e86-4d8c-8fd7-3e241158fcc2"
    client_secret = "b158790e-814f-48f1-a1e3-afdfe9f71be1"
  }

  tags = {
    Environment = "Test"
  }
}

output "client_certificate" {
  value = "${azurerm_kubernetes_cluster.test.kube_config.0.client_certificate}"
}

output "kube_config" {
  value = "${azurerm_kubernetes_cluster.test.kube_config_raw}"
}