variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]{3,20}$", var.project_name))
    error_message = "Project name must be 3-20 characters, lowercase letters, numbers, and hyphens only."
  }
}

variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "test", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, test, staging, prod."
  }
}

variable "location" {
  description = "Azure region for deployment"
  type        = string
  default     = "West Europe"
}

variable "business_unit" {
  description = "Business unit or department"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{2,30}$", var.business_unit))
    error_message = "Business unit must be 2-30 characters, letters, numbers, and hyphens only."
  }
}

variable "cost_center" {
  description = "Cost center for billing allocation"
  type        = string
  validation {
    condition     = can(regex("^[0-9]{4,10}$", var.cost_center))
    error_message = "Cost center must be 4-10 digits."
  }
}

variable "owner_email" {
  description = "Email of the resource owner"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.owner_email))
    error_message = "Must be a valid email address."
  }
}

variable "additional_tags" {
  description = "Additional tags to apply to the resource group"
  type        = map(string)
  default     = {}
}

variable "enable_resource_lock" {
  description = "Enable resource lock to prevent accidental deletion"
  type        = bool
  default     = false
}

variable "lock_level" {
  description = "Level of resource lock (CanNotDelete or ReadOnly)"
  type        = string
  default     = "CanNotDelete"
  validation {
    condition     = contains(["CanNotDelete", "ReadOnly"], var.lock_level)
    error_message = "Lock level must be either CanNotDelete or ReadOnly."
  }
}
