# HOW TO USE

## Deployment Instructions

1. **Add the module to your Terraform configuration:**

```hcl
module "eks_bootstrap" {
  source = "./modules/eks_bootstrap"

  integrations = {
    cluster_name = "your-cluster-name"
    aws_ebs_csi_driver = {
      fstype    = "ext4"
      ebs_type  = "gp3"
      iopsPerGB = 100
      encrypted = true
    }
    aws_efs_csi_driver = {
      name            = "efs-volume"
      encrypted       = true
      subnet_ids      = ["subnet-xxxx", "subnet-yyyy"]
      efs_resource_id = "fs-xxxx"
      security_groups = ["sg-xxxx"]
    }
    aws_mountpoint_s3_csi_driver = {
      name            = "s3-mount"
      s3_bucket_arn   = "arn:aws:s3:::your-bucket"
      create_vpc_endpoint = {
        vpc_id         = "vpc-xxxx"
        route_table_ids = ["rtb-xxxx"]
        bucket_region   = "us-west-2"
      }
    }
    ecr_registries = {
      registry1 = { name = "my-ecr-repo" }
    }
  }

  plugins = {
    dont_wait_for_helm_install = true
    cluster_autoscaler = {
      cluster_name = "your-cluster-name"
      region       = "us-west-2"
      values       = []
    }
    metrics_server = {
      values = []
    }
    nginx_controller = {
      default = {
        scheme_type = "internet-facing"
        alb_config = {
          alb_ingress_traffic_mode = "ip"
          alb_family_type = "ipv4"
          enable_cross_zone = false
        }
        values = []
      }
    }
    aws_alb_controller = {
      eks_cluster_name = "your-cluster-name"
      region           = "us-west-2"
      vpc_id           = "vpc-xxxx"
      values           = []
    }
    argo_cd = {
      values = []
    }
    external_secrets = {
      ssm_path_prefix = "/"
      authorized_iam_role_arn = null
      values = []
    }
    secrets_store_csi_driver = {
      values = []
    }
    loki = {
      values = []
    }
    prometheus = {
      values = []
    }
    cert_manager = {
      values = []
    }
    kubernetes_dashboard = {
      hosts          = ["dashboard.example.com"]
      use_internally = false
      values         = []
    }
    rancher = {
      host                 = "rancher.example.com"
      use_internal_ingress = false
      values               = []
    }
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

- `integrations`: Storage, registry, and driver integrations for EKS
- `plugins`: Helm-based and other Kubernetes add-ons

Optional and advanced settings are documented in `variables.tf` with comments and default values.

---
# OUTPUTS

| Output Name         | Description                                      |
|--------------------|--------------------------------------------------|
| `ecr_registry_ids` | The registry IDs where ECR repositories were created |

Refer to `outputs.tf` for the most up-to-date and detailed output definitions.
