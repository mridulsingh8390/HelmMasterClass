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

List Helm Releases with dev namespace
helm list -n dev 
```

## List Kubernetes Resources

```bash 

# List Kubernetes Pods
kubectl get pods

# List Kubernetes Services
kubectl get svc
Observation: Review the EXTERNAL-IP field and you will see it as localhost. Access the nginx page from local desktop localhost

# Access Nginx Application on local desktop browser
http://localhost:80
http://127.0.0.1:80

# Access Application using curl command
curl http://localhost:80
curl http://127.0.0.1:80

```

## Uninstall Helm Release - NO FLAGS

```bash 

# List Helm Releases
helm ls

# Uninstall Helm Release
helm uninstall <RELEASE-NAME>
helm uninstall mynginx 

## Uninstall Helm Release from Dev NS
helm uninstall mynginx -n dev 

```

## Helm Upgrade with set option

```bash 

# List Helm Repositories
helm repo list

# Add Helm Repository
helm repo add <DESIRED-NAME> <HELM-REPO-URL>
helm repo add mybitnami https://charts.bitnami.com/bitnami

# List Helm Repositories
helm repo list


# Update Helm Repo
helm repo update  # Make sure we get the latest list of charts

# Install Helm Chart
helm install <RELEASE-NAME> <repo_name_in_your_local_desktop/chart_name>
helm install mynginx mybitnami/nginx

# Install helm chart in specific namespace
helm install mynginx mybitnami/nginx --create-namespace dev 


# Helm Upgrade
helm upgrade <RELEASE-NAME> <repo_name_in_your_local_desktop/chart_name> --set <OVERRIDE-VALUE-FROM-values.yaml>
helm upgrade mynginx mybitnami/nginx -n dev --set "image.tag=1.14.2"

```

## List Resources after helm upgrade

```bash 

# List Helm Releases
helm list 
Observation: We should see Revision as 2

# Additional List commands
helm list -n dev --superseded
helm list -n dev --deployed

# List and Describe Pod
kubectl get pods -n dev
kubectl describe pod <POD-NAME> 
Observation: In the Pod Events you should find that "ghcr.io/stacksimplify/kubenginx:2.0.0" is pulled or if already exists on desktop it will be used to create this new pod

# Access Application
http://localhost:<NODE-PORT>
http://localhost:31231
Observation: Version 2 of application should be displayed

```

## Helm History and Status

```bash 

# helm history
helm history RELEASE_NAME

helm history mynginx -n dev


# Helm Status
helm status RELEASE_NAME
helm status mynginx -n dev

# Helm Status - Show Description (display the description message of the named release)
helm status mynginx -n dev --show-desc    

# Helm Status - Show Resources (display the resources of the named release)
helm status mynginx  -n dev --show-resources   

# Helm Status - revision (display the status of the named release with revision)
helm status RELEASE_NAME --revision int
helm status mynginx  -n dev --revision 2

```

## Uninstall Helm Release

```bash 

# Uninstall Helm Release
helm uninstall mynginx -n dev

```