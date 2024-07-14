# ECR Repository
resource "aws_ecr_repository" "timeoff_management" {
  name = "timeoff-management"
}

# EKS Cluster
resource "aws_eks_cluster" "main" {
  name     = "timeoff-management-cluster"
  role_arn = aws_iam_role.eks_role.arn


  vpc_config {
    subnet_ids = aws_subnet.private.*.id
    security_group_ids = [aws_security_group.eks_node_security_group.id]
  }

  depends_on = [aws_iam_role_policy_attachment.eks_policy, aws_subnet.private]
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "timeoff-management-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.private.*.id
  

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }

  depends_on = [aws_eks_cluster.main, aws_subnet.private]
}