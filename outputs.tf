output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.main.name
}

output "resource_group_id" {
  description = "ID of the created resource group"
  value       = azurerm_resource_group.main.id
}

output "location" {
  description = "Azure region where the resource group was deployed"
  value       = azurerm_resource_group.main.location
}

output "tags" {
  description = "Tags applied to the resource group"
  value       = azurerm_resource_group.main.tags
}

output "resource_lock_id" {
  description = "ID of the resource lock (if enabled)"
  value       = var.enable_resource_lock ? azurerm_management_lock.resource_group_lock[0].id : null
}

output "full_resource_info" {
  description = "Complete resource group information"
  value = {
    name         = azurerm_resource_group.main.name
    id           = azurerm_resource_group.main.id
    location     = azurerm_resource_group.main.location
    tags         = azurerm_resource_group.main.tags
    lock_enabled = var.enable_resource_lock
    lock_level   = var.enable_resource_lock ? var.lock_level : null
  }
}
