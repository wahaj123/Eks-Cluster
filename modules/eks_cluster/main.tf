resource "aws_eks_cluster" "eksCluster" {
  name     = var.ekscluster_name
  role_arn = var.eksclusterrole_arn

  vpc_config {

    subnet_ids              = var.private-subnets
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    var.eks_cluster_role-AmazonEKSClusterPolicy,
    var.eks_cluster_role-AmazonEKSVPCResourceController,
  ]
}