# Display name of the Azure AD Group
data "azuread_group" "existing" {
  display_name = var.aad_group_display_name
}

# Add all azurerm access to Azure AD group
resource "azurerm_role_assignment" "rbac" {
  for_each             = var.azurerm_access
  scope                = each.key
  role_definition_name = each.value
  principal_id         = data.azuread_group.existing.id
}
