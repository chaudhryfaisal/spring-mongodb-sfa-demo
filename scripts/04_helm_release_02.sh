#!/usr/bin/env bash
VERSION=0.0.2
helm upgrade "chart-api-service-demo" -i "fic-demo1/chart-api-service" --namespace "released" \
	--set replicaCount=2,image.tag=$VERSION,image.repository=chaudhryfaisal/api-service
