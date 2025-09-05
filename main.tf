provider "aws" {
  region = "us-east-1"
}

module "dev_iam" {
  source   = "./modules/iam_env"
  env_name = "dev"
  groups   = var.dev_groups
}

module "qa_iam" {
  source   = "./modules/iam_env"
  env_name = "qa"
  groups   = var.qa_groups
}

# module "prod_iam" {
#   source   = "./modules/iam_env"
#   env_name = "prod"
#   groups   = var.prod_groups
# }
