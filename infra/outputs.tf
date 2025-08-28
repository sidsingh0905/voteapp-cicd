# output "eks_cluster_endpoint" {
#   value       = module.eks_cluster_endpoint
#   description = "EKS Cluster Endpoint (MASTER COMPONENT--> CONTROL PLANE ENDPOINT)"
  
# }

# output "namespace" {
#   value       = module.eks_cluster_name.name
#   description = "EKS Cluster Name"
  
# }

# output "vpc_id" {
#     value       = module.vpc.vpc_id
#     description = "VPC ID"
  
# }

output "eks_cluster_endpoint" {
  value       = module.eks.eks_cluster_endpoint
  description = "EKS Cluster Endpoint(MASTER COMPONENT--> CONTROL PLANE ENDPOINT)"
}

output "namespace" {
  value       = module.eks.eks_cluster_name
  description = "EKS Cluster Name"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}
