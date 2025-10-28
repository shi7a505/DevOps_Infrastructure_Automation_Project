variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-north-1"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t3.micro"
}

variable "terraform-key" {
  description = "AWS Key Pair Name"
  type        = string
  # هتحط اسم الـ Key Pair بتاعك هنا
}

variable "197.43.146.158" {
  description = "Your IP for SSH access"
  type        = string
  # هتحط IP جهازك هنا
}
