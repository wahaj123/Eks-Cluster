variable "private-subnets" {
  type = list(string)
}
variable "eks_clustername" {
  type = string
}
variable "NodeGroupName" {
  type = string
}
variable "instance_types" {
  type = list(string)
}
variable "capacity_type" {
  type = string
}
variable "desired_size" {
  type = number
}
variable "max_size" {
  type = number
}
variable "min_size" {
  type = number
}
variable "ManageNodeGroupRole-AmazonEKSWorkerNodePolicy" {
  type = map(string)
}
variable "ManageNodeGroupRole-AmazonEKS_CNI_Policy" {
  type = map(string)
}
variable "ManageNodeGroupRole-AmazonEC2ContainerRegistryReadOnly" {
  type = map(string)
}
variable "ManageNodeGroupRole_arn" {
  type = string
}