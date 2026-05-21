#!/bin/bash
set -euxo pipefail

kubectl delete pod $(kubectl get pods -l app=hit-counter -o jsonpath='{.items[0].metadata.name}')
kubectl get pods