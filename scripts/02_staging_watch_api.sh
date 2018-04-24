#!/usr/bin/env bash

watch -c -d -t "curl -vs http://sfa.demo.fic.com/api-service/info 2>&1 | grep 'APP_' | sort"