helm install api-gw-az1 ingress-nginx/ingress-nginx \
    --namespace api-gw \
    --set controller.replicaCount=1 \
    --set controller.nodeSelector."agentpool"=az1 \
    --create-namespace \
    -f api-gw-ingress-controller-config.yml


helm install api-gw-az2 ingress-nginx/ingress-nginx \
    --namespace api-gw \
    --set controller.replicaCount=1 \
    --set controller.nodeSelector."agentpool"=az2 \
    --create-namespace \
    -f api-gw-ingress-controller-config.yml

