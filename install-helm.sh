sudo apt update
sudo apt install -y curl gpg
curl -fsSL https://packages.buildkite.com/helm-linux/helm-debian/gpgkey -o /tmp/helm.asc
gpg --show-keys --with-colons /tmp/helm.asc | grep '^fpr'
sudo mkdir -p /etc/apt/keyrings
sudo install -m 0644 /tmp/helm.asc /etc/apt/keyrings/helm.asc
sudo tee /etc/apt/sources.list.d/helm-stable-debian.sources > /dev/null <<'EOF'
Types: deb
URIs: https://packages.buildkite.com/helm-linux/helm-debian/any/
Suites: any
Components: main
Signed-By: /etc/apt/keyrings/helm.asc
EOF

sudo apt update
sudo apt install -y helm
helm version
kubectl version --client

kubectl cluster-info
kubectl get nodes

# List Config Contexts
kubectl config get-contexts

# Config Current Context
kubectl config current-context