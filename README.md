# Infra Deploy Kit

## Overview

This repository provides a boilerplate for deploying containerized applications and infrastructure resources using Docker, Terraform, and Ansible. It includes modularized configurations for AWS, GitLab, and Cloudflare, as well as an Ansible playbook for post-deployment provisioning.

## Repository Structure

```
.
├── environtment-template
│   ├── ansible-playbook
│   │   └── setup-playbook.yml       # Ansible playbook for provisioning
│   ├── backend-cinfig.hcl.example  # Example Terraform backend configuration
│   ├── main.tf                     # Main Terraform configuration
│   ├── terraform.tfvars            # Terraform variables
│   └── variables.tf                # Terraform variable definitions
├── _modules
│   ├── aws
│   │   ├── ec2                     # EC2 instance management module
│   │   ├── key-pair                # Key pair management module
│   │   ├── s3-bucket               # S3 bucket management module
│   │   └── security-group          # Security group management module
│   ├── cloudflare
│   │   └── r2-bucket               # Cloudflare R2 bucket management module
│   └── gitlab
│       └── git-repository          # GitLab repository management module
└── README.md                       # Documentation for the repository
```

## Prerequisites

- [Terraform](https://www.terraform.io/) >= 1.0.0
- [Ansible](https://www.ansible.com/) >= 2.9

## Usage

### 1. Configure Terraform Backend

Rename `backend-config.hcl.example` to `backend-config.hcl` and update the configuration as needed.

### 2. Define Variables

Rename `terraform.tfvars.example` to `terraform.tfvars` and update with your specific configuration:

```hcl
aws_access_key = "<your-access-key>"
aws_secret_key = "<your-secret-key>"
aws_region     = "<region>"
aws_vpc_id     = "<your-vpc-id>"
aws_user       = "<vm-user>"
ec2_list = [
  {
    name          = "<instance-name>"
    image_id      = "<image-id>"
    instance_type = "<instance-type>"
  }
]

sg_list = [
  {
    name = "example_allow_ssh"
    ingress = {
      description = "allow ssh from internet"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress = {
      description = "allow all egress"
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
]

key_pair_name       = "<key-pair-name>"
gitlab_access_token = "<your-gitlab-access-token>"

repository_list = [
  {
    name        = "<repository-name>"
    description = "Repository for XXXX"
    visibility  = "<private-or-public>"
  }
]
```

### 3. Initialize and Deploy

Run the following commands to deploy infrastructure:

```bash
# If your want to store your state to object storage you can set -backend-config=backend-config.hcl
terraform init -backend-config=backend-config.hcl

# Plan the deployment
terraform plan

# Apply the deployment
terraform apply
```

### 4. Repository and Instance is ready to use

Now push your project to the gitlab repository and deploy on the ec2 instance

## Modules

#### AWS Modules

- **EC2**: Provision EC2 instances.
- **Key Pair**: Manage SSH key pairs.
- **S3 Bucket**: Manage S3 buckets.
- **Security Group**: Configure security groups.

#### Cloudflare Module

- **R2 Bucket**: Manage Cloudflare R2 buckets.

#### GitLab Module

- **Git Repository**: Automate repository creation and management.

## Contributing

Feel free to submit issues and pull requests to improve this boilerplate.

## License

This repository is licensed under the MIT License.
