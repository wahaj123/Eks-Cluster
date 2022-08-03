output "eksclusterrole_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}
output "eks_cluster_role-AmazonEKSClusterPolicy" {
  value = aws_iam_role_policy_attachment.eks_cluster_role-AmazonEKSClusterPolicy
}
output "eks_cluster_role-AmazonEKSVPCResourceController" {
  value = aws_iam_role_policy_attachment.eks_cluster_role-AmazonEKSVPCResourceController
}
output "ManagedNodeGroupRole_arn" {
  value = aws_iam_role.ManageNodeGroupRole.arn
}
output "ManageNodeGroupRole-AmazonEKSWorkerNodePolicy" {
  value = aws_iam_role_policy_attachment.ManageNodeGroupRole-AmazonEKSWorkerNodePolicy
}
output "ManageNodeGroupRole-AmazonEKS_CNI_Policy" {
  value = aws_iam_role_policy_attachment.ManageNodeGroupRole-AmazonEKS_CNI_Policy
}
output "ManageNodeGroupRole-AmazonEC2ContainerRegistryReadOnly" {
  value = aws_iam_role_policy_attachment.ManageNodeGroupRole-AmazonEC2ContainerRegistryReadOnly
}