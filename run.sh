#!/bin/bash

# read -p "Press enter to continue"
./01-build.sh
# read -p "Press enter to continue"
./02-scale.sh
# read -p "Press enter to continue"
./04-terraform.sh
# read -p "Press enter to continue"
./05-scale-terraform.sh
# read -p "Press enter to continue"
./06-teardown.sh