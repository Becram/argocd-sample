#!/bin/bash 
set -xe 
ARGOCD_APP_NAME=$1

pushd sysapps/overlays/dev/"$ARGOCD_APP_NAME"
helm dependency build ../../../helm_base/"$ARGOCD_APP_NAME"
helm template  ../../../helm_base/"$ARGOCD_APP_NAME" --namespace "$ARGOCD_APP_NAME" --name-template "$ARGOCD_APP_NAME" -f values-override.yaml --include-crds > ../../../helm_base/"$ARGOCD_APP_NAME"/all.yml && kustomize build
# cat ../../../helm_base/$ARGOCD_APP_NAME/all.yml
# kubectl apply -k .
# rm -rf   ../../../helm_base/$ARGOCD_APP_NAME/all.yml ../../../helm_base/$ARGOCD_APP_NAME/charts ../../../helm_base/$ARGOCD_APP_NAME/Chart.lock
popd
exit 0
set +x