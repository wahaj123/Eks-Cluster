resource "aws_eks_node_group" "managed_node_group" {
  cluster_name    = var.eks_clustername
  node_group_name = var.NodeGroupName
  node_role_arn   = var.ManageNodeGroupRole_arn
  subnet_ids      = var.private-subnets
  instance_types  = var.instance_types
  capacity_type   = var.capacity_type

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable = 2
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    var.ManageNodeGroupRole-AmazonEKSWorkerNodePolicy,
    var.ManageNodeGroupRole-AmazonEKS_CNI_Policy,
    var.ManageNodeGroupRole-AmazonEC2ContainerRegistryReadOnly,
  ]
}