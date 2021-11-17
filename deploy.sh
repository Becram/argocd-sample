#!/bin/bash 
set -xe 
ARGOCD_APP_NAME=$1

pushd sysapps/overlays/dev/$ARGOCD_APP_NAME
helm dependency build ../../../helm_base/$ARGOCD_APP_NAME
helm template  ../../../helm_base/$ARGOCD_APP_NAME --name-template $ARGOCD_APP_NAME -f values-override.yaml --include-crds > ../../../helm_base/$ARGOCD_APP_NAME/all.yml
# cat ../../../helm_base/$ARGOCD_APP_NAME/all.yml
kubectl apply -k .
rm -fv ../../../helm_base/$ARGOCD_APP_NAME/all.yml
exit 0
popd
set +x