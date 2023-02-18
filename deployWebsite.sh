#!/bin/bash

# while getopts k:h: flag
# do
#     case "${flag}" in
#         k) key=${OPTARG};;
#         h) hostname=${OPTARG};;
#     esac
# done

# if [[ -z "$key" || -z "$hostname" ]]; then
#     printf "\nMissing required parameter.\n"
#     printf "  syntax: deployWebsite.sh -k <pem key file> -h <hostname>\n\n"
#     exit 1
# fi
hostname=communotee.click
key=~/dev/communotee.pem
service=startup

printf "\n----> Deploying files for $service to $hostname with $key\n-------------------------------\n"

# Step 1
printf "\n----> Clear out the previous distribution on the target.\n"
ssh -i $key ubuntu@$hostname << ENDSSH
rm -rf services/${service}/public
mkdir -p services/${service}/public
ENDSSH

# Step 2
printf "\n----> Copy the distribution package to the target.\n"
scp -r -i $key * ubuntu@$hostname:services/$service/public

