## Infrastructure as Code (IaC) Modules

This repository contains reusable Infrastructure as Code (IaC) modules for provisioning and managing cloud resources using Terraform. Each module is designed to be composable and configurable for use in enterprise Kubernetes and cloud-native environments.

### Available Terraform Modules

| Module Name | Description                      | Link |
|-------------|----------------------------------|------|
| VPC         | Virtual Private Cloud networking | [terraform/vpc](./terraform/vpc/README.md) |
| EKS         | Amazon EKS cluster               | [terraform/eks](./terraform/eks/README.md) |
| EKS Bootstrap | EKS add-ons and integrations   | [terraform/eks_bootstrap](./terraform/eks_bootstrap/README.md) |

---
For details on usage, variables, and outputs, see each module's README.
