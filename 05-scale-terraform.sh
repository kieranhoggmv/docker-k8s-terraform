#!/bin/bash
set -euxo pipefail

sed -i 's/default = 1/default = 3/' main.tf
terraform plan
terraform apply
sleep 5
kubectl get pods
