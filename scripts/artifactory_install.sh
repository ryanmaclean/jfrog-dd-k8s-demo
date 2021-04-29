#!/usr/bin/env bash

kubectl create namespace jfrog-platform
helm repo add jfrog https://charts.jfrog.io
helm repo update
helm upgrade --install jfrog-platform --namespace jfrog-platform jfrog/jfrog-platform
cat <<EOF > custom-values.yaml
xray:
  enabled: true
mission-control:
  enabled: true
EOF
helm upgrade --install jfrog-platform --namespace jfrog-platform jfrog/jfrog-platform -f custom-values.yaml
