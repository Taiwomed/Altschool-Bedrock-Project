variable "az_count" {
  description = "The number of Availability Zones to use for the VPC."
  type        = number
  default     = 1
}

variable "node_desired" {
  description = "The desired number of nodes for the EKS cluster. "
  type        = number
  default     = 1
}

variable "node_instance" {
  description = "The EC2 instance type to use for the EKS worker node. t3.micro is eligible for the Free Tier."
  type        = string
  default     = "t3.micro"
}

variable "aws_region" {
  description = "The AWS region to deploy the infrastructure."
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster_version" {
  description = "The Kubernetes version to use for the EKS cluster."
  type        = string
  default     = "1.21"
}
