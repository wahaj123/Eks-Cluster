data "aws_availability_zones" "azs" {}
module "vpc" {
  source            = "./modules/vpc"
  cidr_vpc_block    = var.vpc.cidr_vpc_block
  public            = var.vpc.public
  private           = var.vpc.private
  availability_zone = data.aws_availability_zones.azs.names
}
module "eks_cluster" {
  source                                          = "./modules/eks_cluster"
  private-subnets                                 = module.vpc.private_subnets_ids
  ekscluster_name                                 = var.EksCluster.ekscluster_name
  endpoint_private_access                         = var.EksCluster.endpoint_private_access
  endpoint_public_access                          = var.EksCluster.endpoint_public_access
  eksclusterrole_arn                              = module.iam_role.eksclusterrole_arn
  eks_cluster_role-AmazonEKSClusterPolicy         = module.iam_role.eks_cluster_role-AmazonEKSClusterPolicy
  eks_cluster_role-AmazonEKSVPCResourceController = module.iam_role.eks_cluster_role-AmazonEKSVPCResourceController
}
module "managed_node_group" {
  source                                                 = "./modules/eks_cluster/managed_node_group"
  for_each                                               = var.managed_node_group
  eks_clustername                                        = module.eks_cluster.eks_cluster_name
  NodeGroupName                                          = each.value.NodeGroupName #var.managed_node_group.NodeGroupName
  private-subnets                                        = module.vpc.private_subnets_ids
  instance_types                                         = each.value.instance_types # var.managed_node_group.instance_types
  capacity_type                                          = each.value.capacity_type  #var.managed_node_group.capacity_type
  desired_size                                           = each.value.desired_size   #var.managed_node_group.desired_size
  min_size                                               = each.value.min_size       #var.managed_node_group.min_size
  max_size                                               = each.value.max_size       #var.managed_node_group.max_size
  ManageNodeGroupRole_arn                                = module.iam_role.ManagedNodeGroupRole_arn
  ManageNodeGroupRole-AmazonEKSWorkerNodePolicy          = module.iam_role.ManageNodeGroupRole-AmazonEKSWorkerNodePolicy
  ManageNodeGroupRole-AmazonEKS_CNI_Policy               = module.iam_role.ManageNodeGroupRole-AmazonEKS_CNI_Policy
  ManageNodeGroupRole-AmazonEC2ContainerRegistryReadOnly = module.iam_role.ManageNodeGroupRole-AmazonEC2ContainerRegistryReadOnly
}
module "iam_role" {
  source               = "./modules/iam_role"
  EksClusterRoleName   = var.iam_role.EksClusterRoleName
  ManagedNodeGroupName = var.iam_role.ManagedNodeGroupName
}