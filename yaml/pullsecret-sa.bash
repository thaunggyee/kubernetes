#!/bin/bash

target_ns=${1:-default}

## Create docker registry secrets

## Docker registry
kubectl apply -n ${target_ns} -f yaml/registry-docker-frontiirrndglrunner1.yaml

## Frontiir internal registry
kubectl apply -n ${target_ns} -f yaml/registry-frontiir-net.yaml

## Apply patch to service accounts under this namespace to add imagePullSecret
for svc_acc in $(kubectl get sa -n ${target_ns} -o name)
do
    kubectl patch ${svc_acc} -n ${target_ns} -p '
{
    "imagePullSecrets": [
        {"name": "registry-docker-frontiirrndglrunner1"},
        {"name": "registry-frontiir-net"}
    ]
}'
done
