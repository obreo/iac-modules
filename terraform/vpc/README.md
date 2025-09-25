# HOW TO USE

## Deployment Instructions

1. **Add the module to your Terraform configuration:**

```hcl
module "vpc" {
  source = "./modules/vpc"
  name   = "your-vpc-name"
  vpc_settings = {
    vpc_cidr_block             = "10.0.0.0/16"
    public_subnet_cidr_blocks  = ["10.0.1.0/24", "10.0.2.0/24"] # Optional
    private_subnet_cidr_blocks = ["10.0.101.0/24", "10.0.102.0/24"] # Optional
    create_private_subnets_nat = { nat_per_az = false } # Optional
    availability_zones         = ["us-west-2a", "us-west-2b"] # Optional
    enable_dns_hostnames       = true # Optional
    include_eks_tags = {
      cluster_name    = "your-eks-cluster"
      shared_or_owned = "owned"
    }
    enable_aws_ipv6_cidr_block = {
      public_cidr_count_prefix64  = 0
      private_cidr_count_prefix64 = 0
      ipv6_native                 = false
    }
  }
  security_groups = {
    "app_sg" = {
      name        = "app-sg"
      description = "App security group"
      tags        = { "env" = "dev" }
      inbound = {
        rule_description = "Allow HTTP"
        ports           = [80, 443]
        ip_protocol     = "tcp"
        destination = {
          cidr_ipv4      = "0.0.0.0/0"
          cidr_ipv6      = null
          security_group = null
          prefix_list_id = null
        }
      }
    }
  }
  interface_endpoints = {
    ssm = {
      service         = "com.amazonaws.us-west-2.ssm"
      private_dns     = true
      security_groups = ["sg-xxxx"]
      subnet_ids      = ["subnet-xxxx"]
      connection_ip_type = "ipv4"
      dns_record_ip_type = null
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

- `name`: VPC name
- `vpc_settings`: VPC and subnet configuration
- `security_groups`: Security group definitions
- `interface_endpoints`: Interface endpoint services

Optional and advanced settings are documented in `variables.tf` with comments and default values.

---
# OUTPUTS

The following outputs are available from this module:

| Output Name                | Description                                      |
|----------------------------|--------------------------------------------------|
| `security_group_ids`       | Map of security group names to their IDs         |
| `public_subnet_cidr_blocks`| List of public subnet IDs                        |
| `private_subnet_cidr_blocks`| List of private subnet IDs                      |
| `vpc_id`                   | The VPC ID                                       |
| `public_route_table_id`    | The public route table ID                        |
| `private_route_table_id`   | The private route table ID                       |

Refer to `outputs.tf` for the most up-to-date and detailed output definitions.
