# Get latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Security Group for Controller
resource "aws_security_group" "controller_sg" {
  name        = "terraform-controller-sg"
  description = "Security group for Terraform Controller"

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  # Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Terraform-Controller-SG"
  }
}

# EC2 Instance - Terraform Controller
resource "aws_instance" "terraform_controller" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.controller_sg.id]

  user_data = file("user-data.sh")

  tags = {
    Name = "Terraform-Controller"
    Type = "DevOps-Project"
  }

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }
}
