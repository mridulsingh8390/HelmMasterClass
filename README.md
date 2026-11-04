# Helm MasterClass

## Step:1 - Install Docker and HELM CLI and Kind Env Setup

```bash
# Install Docker and Kind Cluster env.
wget https://github.com/mridulsingh8390/K8S-Troubleshooting-Lab/blob/main/Day-0/01-setup-kind-cluster.sh

bash 01-setup-kind-cluster.sh

# Install helm 

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

```
## Add Repo

```bash 

# Add Bitnami Repo

# List Helm Repositories
helm repo list

# Add Helm Repository
helm repo add <DESIRED-NAME> <HELM-REPO-URL>
helm repo add mybitnami https://charts.bitnami.com/bitnami

# List Helm Repositories
helm repo list

```

## Search Helm Repository
```bash
helm search repo <KEY-WORD>
helm search repo nginx
helm search repo apache
helm search repo wildfly
```

## Install Helm Chart
```bash 

# Update Helm Repo
helm repo update  # Make sure we get the latest list of charts

# Install Helm Chart
helm install <RELEASE-NAME> <repo_name_in_your_local_desktop/chart_name>
helm install mynginx mybitnami/nginx

# Install helm chart in specific namespace
helm install mynginx mybitnami/nginx --create-namespace dev 

```

## List Helm Releases
```bash 

# List Helm Releases (Default Table Output)
helm list 
helm ls

# List Helm Releases (YAML Output)
helm list --output=yaml

# List Helm Releases (JSON Output)
helm list --output=json

# List Helm Releases with namespace flag
helm list --namespace=default
helm list -n default

helm list -n dev 
```