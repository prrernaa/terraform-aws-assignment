# Terraform AWS Assignment

## Overview

This project demonstrates Infrastructure as Code (IaC) using Terraform on AWS.
The assignment focuses on provisioning and managing AWS infrastructure automatically instead of manually creating resources from the AWS Console.

The project covers:

* Terraform installation and setup
* AWS provider configuration
* EC2 instance provisioning
* Security group configuration
* Infrastructure automation
* Terraform state management
* Infrastructure lifecycle management

---

# Project Objective

The primary objective of this assignment is to:

* understand Infrastructure as Code concepts
* automate AWS resource provisioning
* learn Terraform workflow
* manage infrastructure efficiently
* reduce manual cloud configuration
* improve reproducibility and scalability

---

# Technologies Used

| Technology          | Purpose                        |
| ------------------- | ------------------------------ |
| Terraform           | Infrastructure as Code         |
| AWS EC2             | Virtual machine provisioning   |
| AWS Security Groups | Network access control         |
| AWS VPC             | Networking                     |
| AWS IAM             | Authentication and permissions |
| Linux               | Deployment environment         |

---

# Terraform Workflow

```text
Write Terraform Code
        ↓
terraform init
        ↓
terraform validate
        ↓
terraform plan
        ↓
terraform apply
        ↓
AWS Infrastructure Created
```

---

# Project Structure

```text
terraform-aws-assignment/
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
├── terraform.tfvars
├── .gitignore
└── README.md
```

---

# Terraform Files Explanation

## provider.tf

Defines the AWS provider configuration.

Example:

```hcl
provider "aws" {
  region = "us-east-1"
}
```

Purpose:

* connects Terraform to AWS
* specifies AWS region

---

## main.tf

Contains the main infrastructure resources.

Resources may include:

* EC2 instance
* security groups
* networking resources

Example:

```hcl
resource "aws_instance" "example" {
  ami           = "ami-xxxxxxxx"
  instance_type = "t2.micro"
}
```

---

## variables.tf

Defines reusable variables.

Example:

```hcl
variable "instance_type" {
  default = "t2.micro"
}
```

Purpose:

* avoid hardcoding values
* improve reusability
* simplify configuration changes

---

## terraform.tfvars

Stores actual variable values.

Example:

```hcl
instance_type = "t2.micro"
```

---

## outputs.tf

Displays important resource information after deployment.

Example:

```hcl
output "public_ip" {
  value = aws_instance.example.public_ip
}
```

Purpose:

* retrieve EC2 public IP
* expose useful deployment outputs

---

# Prerequisites

Before running the project ensure the following are installed:

* Terraform
* AWS CLI
* AWS Account
* Configured AWS credentials

---

# AWS CLI Configuration

Configure AWS credentials:

```bash
aws configure
```

Provide:

```text
AWS Access Key
AWS Secret Key
Region
Output Format
```

---

# Terraform Installation

Verify Terraform installation:

```bash
terraform --version
```

---

# Steps to Run the Project

## 1. Clone Repository

```bash
git clone https://github.com/prrernaa/terraform-aws-assignment.git
cd terraform-aws-assignment
```

---

## 2. Initialize Terraform

```bash
terraform init
```

Purpose:

* downloads provider plugins
* initializes Terraform working directory

---

## 3. Validate Configuration

```bash
terraform validate
```

Purpose:

* checks Terraform syntax
* identifies configuration issues

---

## 4. Preview Infrastructure Changes

```bash
terraform plan
```

Purpose:

* previews resources to be created
* avoids accidental deployments

---

## 5. Apply Infrastructure

```bash
terraform apply
```

Type:

```text
yes
```

Terraform provisions infrastructure automatically.

---

# Example Infrastructure Created

## EC2 Instance

Terraform provisions:

* Amazon EC2 instance
* public IP
* networking configuration

---

## Security Group

Security group may allow:

| Port | Purpose |
| ---- | ------- |
| 22   | SSH     |
| 80   | HTTP    |
| 443  | HTTPS   |

---

# Terraform State

Terraform stores infrastructure state in:

```text
terraform.tfstate
```

Purpose:

* tracks deployed infrastructure
* manages updates and deletions

---

# Common Terraform Commands

## Initialize

```bash
terraform init
```

---

## Validate

```bash
terraform validate
```

---

## Plan

```bash
terraform plan
```

---

## Apply

```bash
terraform apply
```

---

## Destroy Infrastructure

```bash
terraform destroy
```

Purpose:

* removes all provisioned AWS resources
* prevents unnecessary AWS charges

---

# Important Learning Outcomes

This assignment helped in understanding:

* Infrastructure as Code
* Terraform workflow
* AWS resource automation
* State management
* Cloud provisioning
* Infrastructure reproducibility
* Infrastructure lifecycle management

---

# Common Errors & Fixes

# 1. AWS Credentials Error

## Error

```text
No valid credential sources found
```

## Fix

Run:

```bash
aws configure
```

---

# 2. Terraform Initialization Failure

## Error

```text
Provider download failed
```

## Fix

Check:

* internet connectivity
* Terraform version
* provider configuration

---

# 3. Duplicate Resource Error

## Cause

Resource already exists in AWS.

## Fix

* delete existing resource
* import existing resource into Terraform

---

# 4. Security Group Access Issue

## Problem

Cannot access EC2 instance.

## Fix

Allow inbound rules:

| Port | Source    |
| ---- | --------- |
| 22   | My IP     |
| 80   | 0.0.0.0/0 |

---

# 5. Terraform Destroy Not Working

## Cause

State mismatch.

## Fix

Run:

```bash
terraform refresh
```

Then:

```bash
terraform destroy
```

---

# Infrastructure Lifecycle

```text
terraform apply
        ↓
Infrastructure Created
        ↓
terraform plan
        ↓
Infrastructure Updated
        ↓
terraform destroy
        ↓
Infrastructure Removed
```

---

# Why Terraform Matters

Manual infrastructure management becomes difficult at scale.

Terraform solves:

* manual configuration errors
* inconsistent environments
* repetitive cloud setup
* scalability issues

Benefits:

* automation
* reproducibility
* version control
* faster deployments
* easier collaboration

---

# Best Practices Followed

* reusable variables
* modular structure
* infrastructure automation
* proper resource naming
* infrastructure cleanup using destroy

---

# AWS Cost Management

Important:

AWS resources continue billing until destroyed.

Always run:

```bash
terraform destroy
```

after testing to avoid unnecessary charges.

---

# Screenshots

## Terraform Apply

Add screenshot here:

```text
screenshots/terraform-apply.png
```

---

## EC2 Running

Add screenshot here:

```text
screenshots/ec2-running.png
```

---

## AWS Console

Add screenshot here:

```text
screenshots/aws-console.png
```

---

# Future Improvements

Possible enhancements:

* remote state using S3
* Terraform modules
* autoscaling setup
* load balancer integration
* multi-environment deployment
* CI/CD integration

---

# Conclusion

This assignment demonstrates practical understanding of:

* Terraform
* AWS automation
* Infrastructure as Code
* Cloud provisioning
* Infrastructure lifecycle management

The project highlights how Terraform simplifies cloud infrastructure deployment and management compared to manual AWS Console configuration.
