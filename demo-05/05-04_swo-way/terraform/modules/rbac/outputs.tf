output "rbac_definition_name" {
  value = {
    for index, item in azurerm_role_assignment.rbac : index => item.role_definition_name
  }
  description = "Nome da Definition do RBAC"
}

output "rbac_scope" {
  value = {
    for index, item in azurerm_role_assignment.rbac : index => item.scope
  }
  description = "Escopo de permissionamento do RBAC"
}
