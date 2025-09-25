# HOW TO USE

## Deployment Instructions

1. **Add the module to your Terraform configuration:**

```hcl
module "eks" {
  source = "./modules/eks"

  metadata = {
    name        = "your-cluster-name"
    environment = "dev"
    eks_version = "1.29"
    region      = "us-west-2" # Optional
  }

  cluster_settings = {
    cluster_subnet_ids = ["subnet-xxxx", "subnet-yyyy"] # Required, at least two in different AZs
    allowed_cidrs_to_access_cluster_publicly = ["0.0.0.0/0"] # Optional
    set_custom_pod_cidr_block = "10.0.0.0/16" # Optional
    support_type = "STANDARD" # Optional
    ip_family = "ipv4" # Optional
    security_group_ids = ["sg-xxxx"] # Optional
    enable_endpoint_public_access = true # Optional
    enable_endpoint_private_access = false # Optional
    create_eks_admin_access_iam_group = false # Optional
    create_eks_custom_access_iam_group = [] # Optional
    enable_logging = {
      api               = false
      audit             = false
      authenticator     = false
      controllerManager = false
      scheduler         = false
      retention_in_days = 3
    }
    addons = {
      vpc_cni                         = true
      eks_pod_identity_agent          = true
      snapshot_controller             = false
      aws_guardduty_agent             = false
      amazon_cloudwatch_observability = false
    }
  }

  node_settings = {
    cluster_name    = "your-cluster-name" # Optional
    node_group_name = "your-node-group"   # Optional
    workernode_subnet_ids = ["subnet-xxxx", "subnet-yyyy"]
    taints = [
      { key = "dedicated", value = "gpu", effect = "NoSchedule" }
    ]
    labels = { "role" = "worker" }
    capacity_config = {
      capacity_type  = "ON_DEMAND"
      instance_types = ["t3.medium"]
      disk_size      = 20
    }
    scaling_config = {
      desired         = 2
      max_size        = 3
      min_size        = 1
      max_unavailable = 1
    }
    remote_access = {
      enable                  = false
      ssh_key_name            = null
      allowed_security_groups = []
    }
  }

  fargate_profile = {
    cluster_name         = "your-cluster-name" # Optional
    subnet_ids           = ["subnet-xxxx", "subnet-yyyy"]
    fargate_profile_name = "profile-name" # Optional
    namespace            = "fargate-space" # Optional
  }
}
```

2. **Initialize and apply Terraform:**

```sh
terraform init
terraform plan
terraform apply
```

## Variable Reference

See [`variables.tf`](./variables.tf) for all available variables, types, and default values. Key variables include:

- `metadata`: Cluster metadata (name, environment, eks_version, region)
- `cluster_settings`: Cluster networking, logging, and add-ons
- `node_settings`: Node group configuration
- `fargate_profile`: Fargate profile configuration

Each category can be created independently. For example, to create only an EKS cluster without node groups or Fargate profiles, provide only the `metadata` and `cluster_settings` variables.

Optional and advanced settings are documented in `variables.tf` with comments and default values.

---

# OUTPUTS

The following outputs are available from this module:

| Output Name                        | Description                                                      |
|------------------------------------|------------------------------------------------------------------|
| `endpoint`                         | EKS cluster endpoint URL                                         |
| `kubeconfig_certificate_authority_data` | Certificate authority data for kubeconfig                        |
| `cluster_id`                       | EKS cluster ID(s)                                                |
| `cluster_name`                     | EKS cluster name                                                 |
| `aws_eks_cluster_certificate_data` | Certificate authority data from data source                       |
| `aws_eks_cluster_data`             | Cluster endpoint from data source                                |
| `aws_eks_cluster_name`             | Cluster name from data source                                    |
| `aws_eks_cluster_auth`             | Authentication token for the cluster                             |
| `ecr_registry`                     | (If enabled) ECR registry URL                                    |

Refer to `outputs.tf` for the most up-to-date and detailed output definitions.