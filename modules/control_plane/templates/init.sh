#!/bin/bash

apt-get -yq update
apt-get install -yq \
    ca-certificates \
    curl \
    ntp


# k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL=${k3s_channel} K3S_TOKEN=${k3s_token} sh -s - \
    --flannel-backend=host-gw \
    --disable local-storage \
    --disable-cloud-controller \
    --disable traefik \
    --disable servicelb \
    --node-taint node-role.kubernetes.io/control-plane:NoSchedule \
    --kubelet-arg 'cloud-provider=external' \
    --flannel-iface ens10 \
    --etcd-expose-metrics \
    --kube-controller-manager-arg 'bind-address=0.0.0.0' \
    --kube-proxy-arg 'metrics-bind-address=0.0.0.0' \
    --kube-scheduler-arg 'bind-address=0.0.0.0'

# manifestos addons
while ! test -d /var/lib/rancher/k3s/server/manifests; do
    echo "Waiting for '/var/lib/rancher/k3s/server/manifests'"
    sleep 1
done

# additional user_data
${additional_user_data}
