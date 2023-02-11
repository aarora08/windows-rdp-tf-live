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
  vpc_name     = "${local.account_vars.account_name}-vpc-${local.account_vars.environment}"
}

terraform {
  source = "git@github.com:aarora08/windows-rdp-tf-modules.git//modules/vpc?ref=v${local.semver}"
}

inputs = {
  account_id           = local.account_vars.account_id
  app_env              = local.account_vars.environment
  app_name             = local.account_vars.account_name
  region               = local.account_vars.region
  vpc_name             = local.vpc_name
  enable_dns_hostnames = true
}
