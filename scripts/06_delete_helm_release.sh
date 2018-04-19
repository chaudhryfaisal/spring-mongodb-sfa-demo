#!/usr/bin/env bash

RELEASE=chart-api-service-demo

#Cleanup
helm delete $RELEASE --purge
