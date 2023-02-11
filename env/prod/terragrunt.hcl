locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl", "account.hcl"))

  # Extract the variables we need for easy access
  account_name = local.account_vars.locals.account_name
  environment  = local.account_vars.locals.environment
  region       = local.account_vars.locals.region
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    encrypt        = true
    bucket         = "${local.account_name}-tfstate-${local.environment}"
    region         = local.region
    key            = "tf/${path_relative_to_include()}.tfstate"
    dynamodb_table = "${local.account_name}-terraformlock-${local.environment}"
  }
}

# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.region}"
}
EOF
}
