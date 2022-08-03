output "endpoint" {
  value = aws_eks_cluster.eksCluster.endpoint
}
output "eks_cluster_name" {
  value = aws_eks_cluster.eksCluster.name
}
output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eksCluster.certificate_authority[0].data
}