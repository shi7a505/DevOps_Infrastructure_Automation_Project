# Get latest Ubuntu AMI
data "aws_ami" "ubuntu_app" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Application Servers
resource "aws_instance" "app_servers" {
  count                  = var.app_server_count
  ami                    = data.aws_ami.ubuntu_app.id
  instance_type          = var.app_instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.public[count.index % length(aws_subnet.public)].id
  vpc_security_group_ids = [aws_security_group.app_servers.id]

  user_data = file("${path.module}/user-data/app-server.sh")

  root_block_device {
    volume_size           = 20
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = "${var.environment}-app-server-${count.index + 1}"
    Role = "Application"
  }
}
