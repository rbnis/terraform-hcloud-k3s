variable "cluster_name" {
  description = "Cluster name (prefix for all resource names)"
  default     = "hetzner"
}

variable "control_plane_ipv4" {
  description = "IP address (v4) of control-plane node"
}
