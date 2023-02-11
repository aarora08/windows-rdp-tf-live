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
  name         = "${local.account_vars.account_name}-admin-template-${local.account_vars.environment}"
}

terraform {
  source = "git@github.com:aarora08/windows-rdp-tf-modules.git//modules/ec2_launch_template?ref=v${local.semver}"
}

dependency "network" {
  config_path = "../network"
}

dependency "admin_launch_template" {
  config_path = "../admin_launch_template"
}

inputs = {
  account_id         = local.account_vars.account_id
  app_env            = local.account_vars.environment
  app_name           = local.account_vars.account_name
  region             = local.account_vars.region
  launch_template_id = dependency.admin_launch_template.outputs.launch_template_id
  size               = 1
  name               = "admin"
}
