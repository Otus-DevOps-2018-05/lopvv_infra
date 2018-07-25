#!/bin/bash
set -e

gcloud compute instances create reddit-app\
 --boot-disk-size=10GB \
 --image-family=reddit-full \
 --image-project=infra-210907 \
 --machine-type=g1-small \
 --restart-on-failure \
 --tags=puma-server 
