# DevOps Infrastructure Automation Project

## 🎯 Project Overview

This project demonstrates a complete DevOps workflow using:
- **Terraform** - Infrastructure as Code
- **Ansible** - Configuration Management
- **Jenkins** - CI/CD Automation
- **AWS** - Cloud Infrastructure

## 🏗️ Architecture

```
Local Machine
    ↓
terraform-bootstrap (creates Controller EC2)
    ↓
Terraform Controller EC2
    ↓
terraform-main (creates DevOps Server EC2)
    ↓
DevOps Server EC2 (Jenkins + Apps)
```

## 📁 Project Structure

```
.
├── terraform-bootstrap/   # Creates the Terraform Controller EC2
├── terraform-main/        # Creates the DevOps Main Server
├── ansible/              # Installs Jenkins on DevOps Server
└── README.md
```

## 🚀 Status

🔨 Work in Progress...

## 📝 Prerequisites

- AWS Account
- AWS CLI configured
- Terraform installed
- Ansible installed
- SSH Key Pair created on AWS

## 🛠️ Setup Instructions

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

## 👤 Author

**shi7a505**

---

*This project is part of my DevOps learning journey.*
