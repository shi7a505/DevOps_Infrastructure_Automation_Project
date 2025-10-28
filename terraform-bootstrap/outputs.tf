output "controller_public_ip" {
  description = "Public IP of Terraform Controller"
  value       = aws_instance.terraform_controller.public_ip
}

output "controller_ssh_command" {
  description = "SSH command to connect to Controller"
  value       = "ssh -i ${var.key_name}.pem ubuntu@${aws_instance.terraform_controller.public_ip}"
}
