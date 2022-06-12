#!/bin/bash

apt-get -yq update
apt-get install -yq \
    ca-certificates \
    curl \
    ntp

# k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL=${k3s_channel} K3S_URL=https://${control_plane_internal_ipv4}:6443 K3S_TOKEN=${k3s_token} sh -s - \
    --kubelet-arg 'cloud-provider=external' \
    --flannel-iface ens10 \
    --kube-proxy-arg 'metrics-bind-address=0.0.0.0'

# floating IPs
%{ for ip in floating_ips ~}
ip addr add ${ip} dev eth0
%{ endfor ~}

# additional user_data
${additional_user_data}
