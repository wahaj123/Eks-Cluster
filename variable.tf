variable "vpc" {
  type = object({
    cidr_vpc_block = string
    public         = list(string)
    private        = list(string)
  })
}
variable "EksCluster" {
  type = object({
    ekscluster_name         = string
    endpoint_private_access = bool
    endpoint_public_access  = bool

  })
}

variable "iam_role" {
  type = object({
    EksClusterRoleName   = string
    ManagedNodeGroupName = string
  })
}

variable "managed_node_group" {
  type = map(object({
    NodeGroupName  = string
    instance_types = list(string)
    capacity_type  = string
    desired_size   = number
    max_size       = number
    min_size       = number
  }))
}