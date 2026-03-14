variable "aws_region" {
  type        = string
  description = "AWS region to deploy into"
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Prefix for naming resources"
  default     = "prod-vpc-demo"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDRs for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDRs for private subnets"
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "public_key_path" {
  type        = string
  description = "Path to your SSH public key"
}

variable "allowed_ssh_cidr" {
  type        = string
  description = "CIDR allowed to SSH into bastion/public instances"
  default     = "0.0.0.0/0"
}