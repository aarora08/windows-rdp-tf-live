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
#  source = "git@github.com:aarora08/windows-rdp-tf-modules.git//modules/network?ref=v${local.semver}"
  source = "../../../../tf-modules//modules/network"
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  account_id      = local.account_vars.account_id
  app_env         = local.account_vars.environment
  app_name        = local.account_vars.account_name
  region          = local.account_vars.region
  vpc_id          = dependency.vpc.outputs.vpc_id
  private_subnets = dependency.vpc.outputs.private_subnets
  public_subnets  = dependency.vpc.outputs.public_subnets
  data_subnets    = dependency.vpc.outputs.data_subnets
}
