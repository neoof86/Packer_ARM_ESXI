sudo apt install make
sudo apt install docker.io
git clone https://github.com/vmware-tanzu/cluster-api-provider-bringyourownhost.git
cd cluster-api-provider-bringyourownhost
make host-agent-binaries
sed -i  "s/amd64/arm64/g" Makefile
make host-agent-binaries
