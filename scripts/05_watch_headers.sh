#!/usr/bin/env bash

watch "curl -v 'http://sfa.demo.fic.com/chart-api-service-demo/' 2>&1 | grep --color=none -E 'APP|HOSTNAME' | sort"