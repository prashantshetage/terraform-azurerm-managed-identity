// Required Variables
//**********************************************************************************************
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the user assigned identity"
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the user assigned identity exists"
}

variable "name" {
  type        = string
  description = "(Required) The name of the user assigned identity"
}
//**********************************************************************************************


// Optional Variables
//**********************************************************************************************
variable "role_assignment" {
  type = map(object({
    scope                = string #(Required) The scope at which the Role Assignment applies to
    role_definition_id   = string #(Optional) The Scoped-ID of the Role Definition
    role_definition_name = string #(Optional) The name of a built-in Role. Changing this forces a new resource to be created
  }))
  description = "(Optional) Arguments required to assign roles to managed identity"
  default     = {}
}

variable "identity_prefix" {
  type        = string
  description = "(Optional) Prefix for Postgresql server name"
  default     = ""
}

variable "identity_suffix" {
  type        = string
  description = "(Optional) Suffix for AKS cluster name"
  default     = ""
}

variable "resource_tags" {
  type        = map(string)
  description = "(Optional) Tags for resources"
  default     = {}
}
variable "deployment_tags" {
  type        = map(string)
  description = "(Optional) Tags for deployment"
  default     = {}
}
variable "it_depends_on" {
  type        = any
  description = "(Optional) To define explicit dependencies if required"
  default     = null
}
//**********************************************************************************************


// Local Values
//**********************************************************************************************
locals {
  timeout_duration = "1h"
  identity_name    = "${var.identity_prefix}${var.name}${var.identity_suffix}"
}
//**********************************************************************************************