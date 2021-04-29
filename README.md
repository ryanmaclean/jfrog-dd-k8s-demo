# JFrog + Datadog Demo for Kubernetes

This repo will set up a demo environment suitable for testing JFrog and Datadog on K8s. 

Google's GKE is used as the platform, but this should also work with EKS or AKS with little to no modification. 


## Getting Started 

```bash
git clone https://github.com/ryanmaclean/jfrog-dd-k8s-demo.git
cd jfrog-dd-k8s-demo
```

## Deploy Datadog

```bash
bash scripts/dd_install.sh
```

## Deploy JFrog Artifactory

```bash
bash scripts/artifactory_install.sh
```
