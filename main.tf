terraform {
  required_version = ">= 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80"
    }
  }
}

provider "azurerm" {
  features {}
}

# Local values for consistent naming and tagging
locals {
  resource_group_name = "rg-${var.project_name}-${var.environment}-${var.business_unit}"

  # Standard tags applied to all resources
  common_tags = merge(var.additional_tags, {
    Project       = var.project_name
    Environment   = var.environment
    BusinessUnit  = var.business_unit
    CostCenter    = var.cost_center
    Owner         = var.owner_email
    ManagedBy     = "Stackguardian"
    CreatedDate   = formatdate("YYYY-MM-DD", timestamp())
    Purpose       = "Resource organization and management"
  })
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = local.resource_group_name
  location = var.location
  tags     = local.common_tags

  lifecycle {
    ignore_changes = [
      tags["CreatedDate"], # Prevent updates on timestamp changes
    ]
  }
}

# Optional Resource Lock
resource "azurerm_management_lock" "resource_group_lock" {
  count      = var.enable_resource_lock ? 1 : 0
  name       = "lock-${azurerm_resource_group.main.name}"
  scope      = azurerm_resource_group.main.id
  lock_level = var.lock_level
  notes      = "Prevents accidental deletion of ${azurerm_resource_group.main.name}"

  depends_on = [azurerm_resource_group.main]
}

# Data source for current Azure client configuration
data "azurerm_client_config" "current" {}
