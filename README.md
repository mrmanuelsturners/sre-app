# Elixir Phoenix Application Deployment with Helm

This guide provides step-by-step instructions to deploy an Elixir Phoenix application and a PostgreSQL database using Helm in a Kubernetes cluster. It also includes troubleshooting steps and cleanup instructions.

---

## Prerequisites

1. **Kubernetes Cluster**: A running Kubernetes cluster (e.g., Minikube, Docker Desktop, or a cloud provider like AWS EKS, GKE, or AKS).
2. **Helm**: Helm must be installed. Follow the [official Helm installation guide](https://helm.sh/docs/intro/install/).
3. **kubectl**: The Kubernetes command-line tool must be installed and configured to connect to your cluster.

---

## Steps to Deploy

### 1. **Clone repository**
```bash
 git clone https://github.com/mrmanuelsturners/sre-app.git
```

### 2. **Enter into sre-app directory**
```bash
 cd sre-app
```


### 3. **Run Postgres and sre-app in the stord namespace**
Create a namespace for the deployment:


```bash
NAMESPACE=stord

helm install sre-db oci://registry-1.docker.io/bitnamicharts/postgresql \
  --create-namespace \
  --namespace $NAMESPACE \
  --set auth.database=sre-technical-challenge \
  --set auth.postgresPassword=password

helm install sre-app . \
  --debug \
  --namespace $NAMESPACE \
  --values values.yaml 

```


### 4. **Forward Postgres Port**
```bash
kubectl port-forward svc/sre-db-postgresql 55432:5432 -n stord
```
use ctrl  + c to exit port forwardiing

### 5. **Test Postgres connection (Open new terminal window)**
```bash
psql postgresql://postgres:password@127.0.0.1:55432/sre-technical-challenge
```

to list tables  in postgres shell
```bash 
\dt 
``` 

to exit postgres shell
```bash 
\q
``` 

### 6. **Forward sre-app port to 8080**
```bash
kubectl port-forward svc/sre-app 8080:80 -n stord
```

use ctrl  + c to exit port forwardiing


Visit <http://localhost:8080/todos>



### 6. **Clean up / Shutdown**
```bash
 kubectl delete namespace stord
```