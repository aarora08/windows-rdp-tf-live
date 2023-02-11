# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

include {
  path = find_in_parent_folders()
}

locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl")).locals
}

terraform {
  source = "../../../../tf-modules//modules/open_vpn"
}

dependency "network" {
  config_path = "../network"
}

dependency "shared_key_pair" {
  config_path = "../shared_key_pair"
}

inputs = {
  account_id         = local.account_vars.account_id
  app_env            = local.account_vars.environment
  app_name           = local.account_vars.account_name
  region             = local.account_vars.region
  instance_ami       = "ami-043db3ad3156c6358"
  security_group_ids = [dependency.network.outputs.security_group_ids["vpn"]]
  subnet_id          = dependency.network.outputs.public_subnets[0]
  key_name           = dependency.shared_key_pair.outputs.key_name
}
