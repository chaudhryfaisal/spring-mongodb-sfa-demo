#!/usr/bin/env bash
VERSION=0.0.1
helm upgrade "chart-api-service-demo" -i "fic-demo1/chart-api-service" --namespace "released" \
	--set replicaCount=1,image.tag=$VERSION,image.repository=chaudhryfaisal/api-service
