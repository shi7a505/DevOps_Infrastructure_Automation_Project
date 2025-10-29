variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-north-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["eu-north-1a", "eu-north-1b"]
}

variable "my_ip" {
  description = "Your IP for access"
  type        = string
}

variable "key_name" {
  description = "SSH Key Pair name"
  type        = string
}

variable "jenkins_instance_type" {
  description = "Jenkins instance type"
  type        = string
  default     = "t3.medium"
}

variable "nexus_instance_type" {
  description = "Nexus instance type"
  type        = string
  default     = "t3.medium"
}

variable "sonar_instance_type" {
  description = "SonarQube instance type"
  type        = string
  default     = "t3.medium"
}

variable "app_instance_type" {
  description = "Application server instance type"
  type        = string
  default     = "t3.micro"
}

variable "app_server_count" {
  description = "Number of application servers"
  type        = number
  default     = 2
}
