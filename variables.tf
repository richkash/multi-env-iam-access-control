variable "dev_groups" {
  default = {
    admins = {
      users    = ["alice", "bob"]
      policies = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    }
    readonly = {
      users    = ["carol"]
      policies = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
    }
    writeonly = {
      users    = ["mona"]
      policies = ["arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"]
    }    
  }
}

variable "qa_groups" {
  default = {
    testers = {
      users    = ["dave"]
      policies = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
    }
  }
}

# variable "prod_groups" {
#   default = {
#     ops = {
#       users    = ["eve"]
#       policies = ["arn:aws:iam::aws:policy/PowerUserAccess"]
#     }
#   }
# }
