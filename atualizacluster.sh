#!/bin/bash
kubectl create configmap -n demo-materialescolar --dry-run material-escolar-backend --from-env-file=.env --output yaml | tee configmap.yaml
kubectl apply -f configmap.yaml
kubectl apply -f deployments.yaml
