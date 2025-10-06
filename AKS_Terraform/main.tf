resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.prefix}-law"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.prefix}-dns"

  default_node_pool {
    name       = "agentpool"
    node_count = var.node_count
    vm_size    = var.node_size
  }

  identity {
    type = "SystemAssigned"
  }

  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = file(var.ssh_pub_key)
    }
  }

    oms_agent {
      log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
    }


  network_profile {
    network_plugin = "azure"
  }
  
#   azure_role_based_access_control {
#   enabled = true

#   admin_group_object_ids = [
#     "83e0a29a-8c07-44b6-948a-83ede54121e6"
#   ]
# }

# azure_role_based_access_control {
#     enabled = true
# }
# #    RBAC is now an attribute, not a block
#   enable_rbac = true

#   role_based_access_control {
#     enabled = true
#   }
}
