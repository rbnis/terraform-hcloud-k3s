output "control_plane_ipv4" {
  depends_on  = [module.control_plane]
  description = "Public IP Address of the control-plane node"
  value       = module.control_plane.control_plane_ipv4
}


output "nodes_ipv4" {
  depends_on  = [module.node_group]
  description = "Public IP Address of the worker nodes in groups"
  value = {
    for type, n in module.node_group :
    type => n.node_ipv4
  }
}

output "floating_ips" {
  depends_on  = [module.floating_ip]
  description = "Floating IP addresses that can be used for ingress"
  value = {
    for type, ip in module.floating_ip :
    type => ip.floating_ip
  }
}