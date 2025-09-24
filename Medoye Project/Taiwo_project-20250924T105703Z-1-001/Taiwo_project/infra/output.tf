output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "The endpoint URL of the EKS cluster"
  value       = module.eks.cluster_endpoint
}

#output "eks_cluster_kubeconfig" {
#  description = "The kubeconfig for the EKS cluster"
#  value       = module.eks.kubeconfig
#}

output "vpc_id" {
  description = "The VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_subnet_ids" {
  description = "The VPC subnet IDs"
  value       = module.vpc.private_subnets
}
