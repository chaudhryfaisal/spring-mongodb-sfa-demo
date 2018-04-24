#!/usr/bin/env bash

helm upgrade "chart-api-service-demo" -i "fic-demo1/chart-api-service" --namespace "released" \
	--set replicaCount=1
