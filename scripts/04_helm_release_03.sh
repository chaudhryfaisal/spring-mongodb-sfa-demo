#!/usr/bin/env bash
VERSION=0.0.3
helm upgrade "chart-api-service-demo" -i "fic-demo1/chart-api-service" --namespace "released" \
	--set replicaCount=3,image.tag=$VERSION,image.repository=chaudhryfaisal/api-service
