variable "private-subnets" {
  type = list(string)
}
variable "ekscluster_name" {
  type = string
}
variable "endpoint_private_access" {
  type = bool
}
variable "endpoint_public_access" {
  type = bool
}


variable "eksclusterrole_arn" {
  type = string
}
variable "eks_cluster_role-AmazonEKSClusterPolicy" {
  type = map(string)
}
variable "eks_cluster_role-AmazonEKSVPCResourceController" {
  type = map(string)
}
