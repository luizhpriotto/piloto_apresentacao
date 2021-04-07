#!/bin/bash
sed -e "s/\${tag}/tilt-$(git rev-parse --abbrev-ref HEAD)/" docker-compose-template.yml > docker-compose.yml
sed -e "s/\${tag}/tilt-$(git rev-parse --abbrev-ref HEAD)/" Tiltfile-template > Tiltfile
sed -e "s/\${tag}/tilt-$(git rev-parse --abbrev-ref HEAD)/" deployments-template.yaml > deployments.yaml
kubectl create configmap -n demo-materialescolar --dry-run material-escolar-backend --from-env-file=.env --output yaml | tee configmap.yaml
#sudo usermod -a -G docker $USER
#if [ ! -f ./tilt ]; then
#   curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | bash
#fi
tilt up
##FIM
