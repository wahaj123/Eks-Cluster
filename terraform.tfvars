vpc = {
  cidr_vpc_block = "10.0.0.0/16"
  public         = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private        = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}
EksCluster = {
  ekscluster_name         = "EksCluster"
  endpoint_private_access = true
  endpoint_public_access  = true
}
managed_node_group = {
  managed_node_group_1 = {
    NodeGroupName  = "managed_node_group"
    instance_types = ["t2.medium"]
    capacity_type  = "ON_DEMAND"
    desired_size   = 2
    max_size       = 3
    min_size       = 2
  }
  managed_node_group_2 = {
    NodeGroupName  = "managed_node_group_2"
    instance_types = ["t2.medium"]
    capacity_type  = "ON_DEMAND"
    desired_size   = 2
    max_size       = 3
    min_size       = 2
  }
}
iam_role = {
  EksClusterRoleName   = "eksCluster-role"
  ManagedNodeGroupName = "eks-node-group-role"
}