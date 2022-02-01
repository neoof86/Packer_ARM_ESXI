mkdir ~/.kube
cp /etc/kubernetes/admin.conf ~/.kube/config
kubectl apply -f https://github.com/antrea-io/antrea/releases/download/v1.4.0/antrea.yml

