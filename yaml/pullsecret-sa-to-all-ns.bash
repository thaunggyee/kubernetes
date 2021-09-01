#!/bin/bash

for ns in $(kubectl get namespaces -o name)
do
    ./add_docker_secret_to_sa.sh ${ns##*/}
done
