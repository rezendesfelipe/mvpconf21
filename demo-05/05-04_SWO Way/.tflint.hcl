rule "terraform_module_pinned_source" {
  enabled          = false
}

rule "terraform_naming_convention" {
	enabled = true
	format = "snake_case"
}
