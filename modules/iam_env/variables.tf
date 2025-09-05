variable "env_name" {
  description = "Environment name (dev/qa/prod)"
  type        = string
}

variable "groups" {
  description = <<EOT
Map of groups for this environment.
Each group has:
- users    (list of IAM usernames)
- policies (list of IAM policy ARNs)
EOT
  type = map(object({
    users    = list(string)
    policies = list(string)
  }))
}
