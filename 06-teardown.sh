#!/bin/bash
set -euxo pipefail

terraform destroy -auto-approve
sed -i 's/default = 3/default = 1/' main.tf
rm -rf .terraform
rm .terraform*
rm terraform.tfstate*

