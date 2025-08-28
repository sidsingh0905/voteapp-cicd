resource "aws_iam_role" "cluster" {    
    name = "${var.cluster_name}-eks-role"
    
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action    = "sts:AssumeRole"
                Effect    = "Allow"
                Principal = {
                    Service = "eks.amazonaws.com"
                }
            }
        ]
    })
  
}

resource "aws_iam_role_policy_attachment" "cluster_policy" {
    role       = aws_iam_role.cluster.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_cluster" "main" {
    name     = var.cluster_name
    role_arn = aws_iam_role.cluster.arn
    version = var.cluster_version
    vpc_config {
        subnet_ids = var.subnet_ids
    }
    depends_on = [aws_iam_role_policy_attachment.cluster_policy]
        }



resource "aws_iam_role" "workernode" {
    name = "${var.cluster_name}-node-role"
    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "worker_policy" {
for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ])

  policy_arn = each.value
    role       = aws_iam_role.workernode.name
}

resource "aws_eks_node_group" "main" {
 for_each = var.node_groups
    cluster_name    = aws_eks_cluster.main.name
    node_group_name = each.key
    node_role_arn   = aws_iam_role.workernode.arn
    subnet_ids      = var.subnet_ids
    scaling_config {
        desired_size = each.value.scaling_config.desired_size
    max_size     = each.value.scaling_config.max_size
    min_size     = each.value.scaling_config.min_size
    }
    depends_on      = [aws_iam_role_policy_attachment.worker_policy] 
}