# Get latest Ubuntu AMI
data "aws_ami" "ubuntu_sonar" {
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

# SonarQube Server
resource "aws_instance" "sonarqube" {
  ami                    = data.aws_ami.ubuntu_sonar.id
  instance_type          = var.sonar_instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.sonarqube.id]

  user_data = file("${path.module}/user-data/sonarqube.sh")

  root_block_device {
    volume_size           = 30
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = "${var.environment}-sonarqube-server"
    Role = "Code Quality"
  }
}
