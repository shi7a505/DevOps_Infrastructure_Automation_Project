# DevOps Infrastructure Automation Project

## Project Overview

This repository demonstrates a complete DevOps workflow using the following tools:
- **Terraform** for Infrastructure as Code
- **Ansible** for configuration management
- **Jenkins** for CI/CD automation
- **AWS** as the cloud provider

## Architecture

```
Local Machine
    ↓
terraform-bootstrap (creates Controller EC2)
    ↓
Terraform Controller EC2
    ↓
terraform-main (creates DevOps Server EC2)
    ↓
DevOps Server EC2 (Jenkins + Applications)
```

## Project Structure

```
.
├── terraform-bootstrap/   # Creates the Terraform Controller EC2
├── terraform-main/        # Creates the DevOps Main Server
├── ansible/               # Installs Jenkins on DevOps Server
└── README.md
```

## Prerequisites

- AWS account
- AWS CLI configured
- Terraform installed
- Ansible installed
- SSH key pair created on AWS

## Setup Instructions

### Phase 1: Bootstrap (Create Controller)
```bash
cd terraform-bootstrap
terraform init
terraform apply
```

### Phase 2: Main Infrastructure (From Controller)
```bash
ssh into controller
cd terraform-main
terraform init
terraform apply
```

### Phase 3: Configure with Ansible
```bash
cd ansible
ansible-playbook -i inventory.ini install-jenkins.yml
```

## Author

**shi7a505**

---

This repository is part of my DevOps learning and practice.
