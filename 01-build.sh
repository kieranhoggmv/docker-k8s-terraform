#!/bin/bash
set -euxo pipefail

docker build -t hit-counter-app:latest .
kubectl apply -f redis.yaml
kubectl apply -f app.yaml
kubectl get pods
kubectl get services
echo "Waiting..."
sleep 5
curl http://localhost:5000