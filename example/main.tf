module "secrets" {
  source                    = "./module"
  enable_secret_manager_api = var.enable_secret_manager_api
  secrets                   = var.secrets
}