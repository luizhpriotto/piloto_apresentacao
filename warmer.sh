#!/bin/bash
kubectl run warmer-$(git rev-parse --abbrev-ref HEAD) -n build \
--rm --stdin=true \
--image=gcr.io/kaniko-project/warmer:latest --restart=Never \
--overrides='{
  "apiVersion": "v1",
  "spec": {
    "containers": [
      {
        "name": "warmer-'$(git rev-parse --abbrev-ref HEAD)'",
        "image": "gcr.io/kaniko-project/warmer:latest",
        "stdin": true,
        "stdinOnce": true,
        "args": [
          "--cache-dir=/cache",
          "--image=python:3.6-buster"
        ],
        "volumeMounts": [
          {
            "name": "cache",
            "mountPath": "/cache",
            "subPath": "cache",
            "readOnly": false
          }
        ]
      }
    ],
    "volumes": [
      {
        "name": "cache",
        "persistentVolumeClaim": {
	         "claimName": "kaniko",
           "persistentVolumeClaimId": "build:kaniko",
           "readOnly": false
        }
      }
    ]
  }
}'