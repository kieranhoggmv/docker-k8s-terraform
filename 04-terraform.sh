#!/bin/bash
set -euxo pipefail

kubectl scale deployment app-deployment --replicas=1
terraform init
terraform import kubernetes_deployment.redis default/redis-deployment
terraform import kubernetes_deployment.app default/app-deployment
terraform import kubernetes_service.redis_service default/redis-service
terraform import kubernetes_service.app_service default/app-service
terraform plan
terraform apply
sleep 5
kubectl get pods