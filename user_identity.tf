// User assigned Managed Identity
//**********************************************************************************************
resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  resource_group_name = var.resource_group_name
  location            = var.location

  name = local.identity_name

  tags       = merge(var.resource_tags, var.deployment_tags)
  depends_on = [var.it_depends_on]

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }

  timeouts {
    create = local.timeout_duration
    delete = local.timeout_duration
  }
}
//**********************************************************************************************


// Role assignment to Managed Identity
//**********************************************************************************************
resource "azurerm_role_assignment" "role_assignment" {
  for_each             = var.role_assignment
  scope                = each.value.scope
  principal_id         = azurerm_user_assigned_identity.user_assigned_identity.principal_id
  role_definition_name = each.value.role_definition_name
  role_definition_id   = each.value.role_definition_id
}
//**********************************************************************************************