output "cluster_addons" {
  #   value = module.eks.cluster_addons 
  value = {
    for k, v in module.eks.cluster_addons : k => v.addon_name
  }
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_iam_role_arn" {
  value = module.eks.cluster_iam_role_arn
}


output "cluster_version" {
  value = module.eks.cluster_version
}

output "eks_managed_node_groups_blue" {
  value = module.eks.eks_managed_node_groups["blue"].iam_role_name
}

output "eks_managed_node_groups_green" {
  value = module.eks.eks_managed_node_groups["green"].iam_role_name
}



# output "eks_managed_node_groups" {
#     value = module.eks.eks_managed_node_groups[*]
# }

