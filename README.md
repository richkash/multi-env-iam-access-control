# multi-env-iam-access-control

## Highlights
- Automated IAM User, Group, and Policy Management across Dev, QA, and Prod environments.
- Supports multiple groups per environment (e.g., dev-admins, dev-readonly, qa-testers).
- Users and policies are iterable lists defined in variables → just edit the lists to add/remove users or policies.
- Clean Terraform outputs show exactly:
  - Which groups exist in each environment
  - Which users belong to which groups
  - Which policies are attached to each group

## Why the need ?
Challenge: In organizations, if IAM is managed manually in the AWS console.
- Risk of inconsistent access across environments.
- Hard to track who has which permissions.
- Manual changes often lead to drift and security gaps.

## How ?
- Centralizes IAM management in Terraform code
- Easy to scale → just update a list in variables.tf
- Enforces least privilege by scoping policies per environment


---

## Example Usage

### Adding a New User
To add a new Dev admin (`john`):
```hcl
variable "dev_groups" {
  default = {
    admins = {
      users    = ["alice", "bob", "john"] # added john
      policies = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    }
  }
}
```
Run -> terraform apply

### Removing Access
```hcl
users = ["alice", "bob"] # removed john
```

### Updating Policies
```hcl
policies = [
  "arn:aws:iam::aws:policy/AdministratorAccess",
  "arn:aws:iam::aws:policy/AmazonS3FullAccess"
]
```

## Future Expansion Ideas
- Cross-Account Access: Allow CI/CD pipelines in one account to assume roles in others
- Policy as Code: Use Sentinel/OPA to enforce IAM best practices in CI/CD.
- MFA Enforcement: Require MFA for certain groups/roles (especially in Prod)
