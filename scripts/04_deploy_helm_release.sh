#!/usr/bin/env bash

BUCKET_NAME="fic-demo1"
NS="released"
helm upgrade $RELEASE -i $BUCKET_NAME/chart-api-service --namespace $NS --set replicaCount=1
