# VPC Outputs
output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value       = aws_subnet.private[*].id
}

# Jenkins Outputs
output "jenkins_public_ip" {
  description = "Jenkins Server Public IP"
  value       = aws_instance.jenkins.public_ip
}

output "jenkins_url" {
  description = "Jenkins URL"
  value       = "http://${aws_instance.jenkins.public_ip}:8080"
}

output "jenkins_ssh" {
  description = "SSH command for Jenkins"
  value       = "ssh -i ~/.ssh/${var.key_name}.pem ubuntu@${aws_instance.jenkins.public_ip}"
}

# Nexus Outputs
output "nexus_public_ip" {
  description = "Nexus Server Public IP"
  value       = aws_instance.nexus.public_ip
}

output "nexus_url" {
  description = "Nexus URL"
  value       = "http://${aws_instance.nexus.public_ip}:8081"
}

output "nexus_ssh" {
  description = "SSH command for Nexus"
  value       = "ssh -i ~/.ssh/${var.key_name}.pem ubuntu@${aws_instance.nexus.public_ip}"
}

# SonarQube Outputs
output "sonarqube_public_ip" {
  description = "SonarQube Server Public IP"
  value       = aws_instance.sonarqube.public_ip
}

output "sonarqube_url" {
  description = "SonarQube URL"
  value       = "http://${aws_instance.sonarqube.public_ip}:9000"
}

output "sonarqube_ssh" {
  description = "SSH command for SonarQube"
  value       = "ssh -i ~/.ssh/${var.key_name}.pem ubuntu@${aws_instance.sonarqube.public_ip}"
}

# App Servers Outputs
output "app_servers_public_ips" {
  description = "Application Servers Public IPs"
  value       = aws_instance.app_servers[*].public_ip
}

output "app_servers_urls" {
  description = "Application Servers URLs"
  value       = [for ip in aws_instance.app_servers[*].public_ip : "http://${ip}:8080"]
}

# Summary
output "infrastructure_summary" {
  description = "Infrastructure Summary"
  value       = <<-EOT
  
  ========================================
  INFRASTRUCTURE DEPLOYED SUCCESSFULLY
  ========================================
  
  Jenkins:    http://${aws_instance.jenkins.public_ip}:8080
  Nexus:      http://${aws_instance.nexus.public_ip}:8081
  SonarQube:  http://${aws_instance.sonarqube.public_ip}:9000
  
  App Server 1: http://${aws_instance.app_servers[0].public_ip}:8080
  App Server 2: http://${aws_instance.app_servers[1].public_ip}:8080
  
  ========================================
  EOT
}
