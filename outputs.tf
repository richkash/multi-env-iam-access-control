output "dev_iam_summary" {
  value = {
    groups   = module.dev_iam.group_names
    users    = module.dev_iam.group_users
    policies = module.dev_iam.group_policies
  }
}

output "qa_iam_summary" {
  value = {
    groups   = module.qa_iam.group_names
    users    = module.qa_iam.group_users
    policies = module.qa_iam.group_policies
  }
}

# output "prod_iam_summary" {
#   value = {
#     groups   = module.prod_iam.group_names
#     users    = module.prod_iam.group_users
#     policies = module.prod_iam.group_policies
#   }
# }
