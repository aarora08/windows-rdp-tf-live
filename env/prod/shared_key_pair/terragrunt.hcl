# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

include {
  path = find_in_parent_folders()
}

locals {
  semver       = "1.0.0"
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl")).locals
}

terraform {
  source = "git@github.com:aarora08/windows-rdp-tf-modules.git//modules/shared_key_pair?ref=v${local.semver}"
}

inputs = {
  account_id = local.account_vars.account_id
  app_env    = local.account_vars.environment
  app_name   = local.account_vars.account_name
  region     = local.account_vars.region
}
