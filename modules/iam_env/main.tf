# Create IAM groups
resource "aws_iam_group" "env_groups" {
  for_each = var.groups
  name     = "${var.env_name}-${each.key}"
}

# Create IAM users (deduplicated across all groups)
resource "aws_iam_user" "env_users" {
  for_each = toset(flatten([for g in values(var.groups) : g.users]))
  name     = each.value
}

# Flatten group → users into user→group pairs
locals {
  user_group_pairs = flatten([
    for group_name, group in var.groups : [
      for user in group.users : {
        group = group_name
        user  = user
      }
    ]
  ])

  group_policy_pairs = flatten([
    for group_name, group in var.groups : [
      for policy in group.policies : {
        group  = group_name
        policy = policy
      }
    ]
  ])
}

# User memberships
resource "aws_iam_user_group_membership" "env_user_membership" {
  for_each = {
    for pair in local.user_group_pairs :
    "${pair.group}-${pair.user}" => pair
  }

  user   = aws_iam_user.env_users[each.value.user].name
  groups = [aws_iam_group.env_groups[each.value.group].name]
}

# Attach policies to groups
resource "aws_iam_group_policy_attachment" "env_group_policies" {
  for_each = {
    for pair in local.group_policy_pairs :
    "${pair.group}-${basename(pair.policy)}" => pair
  }

  group      = aws_iam_group.env_groups[each.value.group].name
  policy_arn = each.value.policy
}
