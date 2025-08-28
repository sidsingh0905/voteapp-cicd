variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
  
}

variable "cluster_version" {
  description = "EKS Cluster Version"
  type        = string
  default     = "1.24" 
  
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  
}
variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
  
}
variable "node_groups" {
  description = "EKS node group configuration"
  type = map(object({
    instance_types = list(string)
    capacity_type  = string
    scaling_config = object({
      desired_size = number
      max_size     = number
      min_size     = number
    })
  }))
}

  
  
