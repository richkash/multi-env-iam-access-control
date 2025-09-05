# Users per group
output "group_users" {
  value = {
    for group_name, group in var.groups :
    group_name => [for p in group.users : p]
  }
}

# Policies per group
output "group_policies" {
  value = {
    for group_name, group in var.groups :
    group_name => [for p in group.policies : p]
  }
}

# Group names
output "group_names" {
  value = { for k, g in aws_iam_group.env_groups : k => g.name }
}
