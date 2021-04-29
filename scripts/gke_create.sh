#!/usr/bin/env bash

# Create a GKE cluster using the GCP cloud shell. 
# Note: you'll want to update the following variables

PROJECT="YOURPORJECT" # Found via https://console.cloud.google.com/home/dashboard
CLUSTERNAME="default" # Define a cluster name to be used
REGION="us-west-1" # Pick the region to which you'll deploy
VERSION="1.17.17-gke.3700" # Select a version
TYPE="e2-standard-2" # Choose an instance type
EMAIL="" # Optionally set your email as a tag for the resources
PURPOSE="" # Optionally set a purpose tag defining the purpose of the cluster
NUMNODES="3" # Set the number of nodes
NETWORK="default" # Select the network in which the cluster will deploy
SUBNETWORK="default" # Select the subnet within the network you'll use
MAXNODES="3" # Maximum number of nodes per zone
DISKSIZE="100"

gcloud beta container \
  --project "$PROJECT" \
  clusters create "$CLUSTERNAME" \
  --region "$REGION" \
  --no-enable-basic-auth \
  --cluster-version "$VERSION" \
  --release-channel "stable" \
  --machine-type "$TYPE" \
  --image-type "UBUNTU" \
  --disk-type "pd-standard" \
  --disk-size "$DISKSIZE" \
  --metadata owner=$YOUREMAIL,purpose=$PURPOSE,disable-legacy-endpoints=true \
  --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
  --num-nodes "$NUMNODES" \
  --enable-stackdriver-kubernetes \
  --enable-ip-alias \
  --network "projects/$PROJECT/global/networks/$NETWORK" \
  --subnetwork "projects/$PROJECT/regions/us-west1/subnetworks/$SUBNETWORK" \
  --default-max-pods-per-node "110" \
  --enable-autoscaling \
  --min-nodes "0" \
  --max-nodes "$MAXNODES" \
  --no-enable-master-authorized-networks \
  --addons HorizontalPodAutoscaling,HttpLoadBalancing \
  --enable-autoupgrade \
  --enable-autorepair \
  --max-surge-upgrade 1 \
  --max-unavailable-upgrade 0
  
# Retrieve the credentials once the cluster has been created
gcloud container clusters get-credentials $CLUSTER --region $REGION --project $PROJECT
