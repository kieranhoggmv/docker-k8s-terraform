#!/bin/bash
set -eo pipefail

kubectl scale deployment app-deployment --replicas=3
for i in {1..5}; do
    curl http://localhost:5000
    sleep 2
done