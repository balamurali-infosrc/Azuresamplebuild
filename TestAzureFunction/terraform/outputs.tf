output "function_app_name" {
  value = azurerm_linux_function_app.function.name
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
