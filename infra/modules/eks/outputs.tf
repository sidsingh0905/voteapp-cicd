output "eks_cluster_endpoint" {
  value = aws_eks_cluster.main.endpoint
  description = "EKS Cluster Endpoint (MASTER COMPONENT--> CONTROL PLANE ENDPOINT)"
  
}

output "eks_cluster_name" {
  value = aws_eks_cluster.main.name
  description = "EKS Cluster Name"
  
}