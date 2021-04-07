#!/bin/bash
echo "
Você já efetuou o 

######   ######   ##   ##   ##   ##  ######  ######    #####
#        #    #   # # # #   # # # #    #       #           #
#        #    #   #  #  #   #  #  #    #       #        ###
#        #    #   #     #   #     #    #       #       
#####    ######   #     #   #     #  #####     #        #

A as modificações do cluster de demo serão somente refletidas após o commit nesta branch!
"

kubectl create configmap -n demo-materialescolar --dry-run material-escolar-backend --from-env-file=.env --output yaml | tee configmap.yaml
kubectl get deployment --all-namespaces | awk 'match($6,/[0-9]+d/) {print $1}' | grep demo | kubectl scale deploy -n demo-materialescolar --replicas=1 --all
sleep 5
kubectl apply -f configmap.yaml
kubectl apply -f deployments.yaml
