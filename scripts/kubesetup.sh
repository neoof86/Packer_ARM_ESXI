swapoff -a
rm /swap.img
sed -i "/swap.img/d" /etc/fstab
cat <<EOF | tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF
cat <<EOF | tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
apt-get update;apt-get install -y containerd
mkdir -p /etc/containerd
containerd config default | tee /etc/containerd/config.toml
sed -i 's/SystemdCgroup.*/SystemdCgroup = true/g' /etc/containerd/config.toml
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
add-apt-repository 'deb https://apt.kubernetes.io/ kubernetes-xenial main' -y
apt update
apt install -y kubelet=1.22.0-00 kubeadm=1.22.0-00 kubectl=1.22.0-00
apt-mark hold containerd kubelet kubeadm kubectl
systemctl enable kubelet.service
systemctl enable containerd.service
#reboot
