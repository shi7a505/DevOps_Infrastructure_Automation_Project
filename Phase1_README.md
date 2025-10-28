# Phase 1: Terraform Bootstrap - Controller EC2

## ✅ Completed Tasks:
- Created Terraform configuration for Controller EC2
- Deployed EC2 instance in `eu-north-1` region
- Installed Terraform, Ansible, and AWS CLI via user-data
- Configured Security Group for SSH access

## 📊 Resources Created:
- **EC2 Instance**: Terraform-Controller (t3.micro, Ubuntu)
- **Security Group**: terraform-controller-sg
- **Region**: eu-north-1 (Stockholm)
- **Public IP**: 13.60.28.234

## 🔑 Access:
```bash
ssh -i ~/.ssh/terraform-key.pem ubuntu@13.60.28.234
```

## 🛠️ Installed Tools:
- Terraform v1.13.4
- Ansible 2.17.14
- AWS CLI 2.31.24

## 📂 Project Structure:
```
terraform-bootstrap/
├── provider.tf       # AWS provider configuration
├── variables.tf      # Input variables
├── main.tf          # EC2 and Security Group resources
├── outputs.tf       # Output values
├── user-data.sh     # Bootstrap script
└── terraform.tfvars # Variable values (gitignored)
```

## 📅 Completion Date:
2025-10-28 23:09 UTC

## 👤 Completed By:
shi7a505
