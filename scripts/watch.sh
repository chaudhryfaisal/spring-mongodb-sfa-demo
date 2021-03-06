#!/usr/bin/env bash
#echo 'GET http://sfa.demo.fic.com/chart-api-service-demo/' | \
#    vegeta attack -rate 10 -duration 10m | vegeta dump 

echo 'GET http://sfa.demo.fic.com/chart-api-service-demo/' | \
    vegeta attack -rate 10 -duration 10m | vegeta dump | \
    jaggr @count=rps \
          hist\[100,200,300,400,500\]:code \
          p25,p50,p95:latency \
          sum:bytes_in \
          sum:bytes_out | \
    jplot rps+code.hist.100+code.hist.200+code.hist.300+code.hist.400+code.hist.500 \
          latency.p95+latency.p50+latency.p25 \
          bytes_in.sum+bytes_out.sum
