#!/usr/bin/env bash

watch -c -d -n 1 -t "curl -v 'http://sfa.demo.fic.com/chart-api-service-demo/' 2>&1 | grep APP_ | sort"