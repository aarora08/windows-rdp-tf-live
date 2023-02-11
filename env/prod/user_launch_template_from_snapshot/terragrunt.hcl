# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

include {
  path = find_in_parent_folders()
}

locals {
  semver       = "1.1.0"
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl")).locals
  name         = "user-replica"
}

terraform {
  source = "git@github.com:aarora08/windows-rdp-tf-modules.git//modules/launch_template_from_snapshot?ref=v${local.semver}"
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
  name               = local.name
  security_group_ids = [dependency.network.outputs.security_group_ids["server_runtime"]]
  subnet_id          = dependency.network.outputs.private_subnets[0]
  key_name           = dependency.shared_key_pair.outputs.key_name
  #  snapshot_id        = "snap-08878f50772d722d2"
  volume_id = "vol-0dd2d03468f403c8c"
}
