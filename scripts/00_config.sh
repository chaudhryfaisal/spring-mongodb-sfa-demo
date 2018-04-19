#!/usr/bin/env bash

#Kube config
export KUBECONFIG=/Users/e037318/_Dev/_Proj/2018/kubernetes/code/k8/installer/clusters/fic-demo1/kube_config

#Helm setup
BUCKET_NAME="fic-demo1"
HELM_CHART_REGISTRY="https://${BUCKET_NAME}.storage.googleapis.com/stable"
STABLE_REPO_NAME="$BUCKET_NAME"

helm repo add ${STABLE_REPO_NAME} ${HELM_CHART_REGISTRY}
helm update

#DNS Setup
DOMAIN='sfa.demo.fic.com'
#INGRESS_IP=$(kubectl get svc ingress-nginx-nginx-ingress-controller -o jsonpath='{ $.status.loadBalancer.ingress[0].ip}')
INGRESS_IP='35.225.88.1'
sudo sed -i '' "/$DOMAIN/d" /etc/hosts
echo -e "$INGRESS_IP $DOMAIN \n"| sudo tee -a /etc/hosts
grep $DOMAIN /etc/hosts