module "account" {
  source = ".git@github.com:aarora08/windows-rdp-tf-modules.git//modules/account"
  app_name   = var.app_name
  app_env    = var.app_env
  account_id = var.account_id
  region     = var.region
  bucket     = var.bucket
}
