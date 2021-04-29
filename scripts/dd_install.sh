#!/usr/bin/env bash

DD_API_KEY=”YOURAPIKEY” # Found at https://app.datadoghq.com/account/settings#api

# Add Helm Repo
helm repo add datadog https://helm.datadoghq.com
helm repo add stable https://charts.helm.sh/stable
helm repo update

# Create Secret for Deployment
kubectl create secret generic datadog-agent --from-literal api-key="$DD_API_KEY" --namespace="default"

# Setup RBAC
kubectl apply -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/clusterrole.yaml"
kubectl apply -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/serviceaccount.yaml"
kubectl apply -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/clusterrolebinding.yaml"

# Deploy Datadog
helm install datadog -f ../helm/values.yaml --set datadog.apiKey="${DD_API_KEY}" datadog/datadog
