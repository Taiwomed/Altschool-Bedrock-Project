
# EKS Cluster with 1 node
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.17"

  cluster_name    = local.name
  cluster_version = "1.29"
  subnet_ids      = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id

  eks_managed_node_groups = {
    default = {
      desired_size = 1   # 1 Node for Free Tier
      max_size     = 1
      min_size     = 1
      instance_types = ["t3.micro"]  # t3.micro for Free Tier
    }
  }

  cluster_endpoint_public_access = true
  cluster_endpoint_private_access = true

  tags = local.tags
}

data "aws_availability_zones" "available" {}
