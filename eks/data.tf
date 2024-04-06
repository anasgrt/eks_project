data "aws_availability_zones" "available" {}

data "aws_region" "current" {}

# for Providers Configs:
data "aws_eks_cluster_auth" "education_cluster" {
  name = local.cluster_name
}
data "aws_eks_cluster" "education_cluster" {
  depends_on = [module.eks]
  name       = local.cluster_name
} 