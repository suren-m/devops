# Creating a TLS enabled Ingress Controller

1. Add `ingress-nginx` helm repo

   `helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx`

2. Use helm to deploy the nginx ingress controller (linux nodepool based cluster)

```
helm install nginx-tls-ingress ingress-nginx/ingress-nginx \
    --namespace nginx-tls-ingress \
    --set controller.replicaCount=2 \
    --create-namespace
```

3. Successful Output (can also be retrieved using `helm status nginx-tls-ingress -n nginx-tls-ingress`)

```
NAME: nginx-tls-ingress
LAST DEPLOYED: Mon Jul 12 12:30:22 2021
NAMESPACE: nginx-tls-ingress
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The ingress-nginx controller has been installed.
It may take a few minutes for the LoadBalancer IP to be available.
You can watch the status by running 'kubectl --namespace nginx-tls-ingress get services -o wide -w nginx-tls-ingress-ingress-nginx-controller'

An example Ingress that makes use of the controller:

  apiVersion: networking.k8s.io/v1beta1
  kind: Ingress
  metadata:
    annotations:
      kubernetes.io/ingress.class: nginx
    name: example
    namespace: foo
  spec:
    rules:
      - host: www.example.com
        http:
          paths:
            - backend:
                serviceName: exampleService
                servicePort: 80
              path: /
    # This section is only required if TLS is to be enabled for the Ingress
    tls:
        - hosts:
            - www.example.com
          secretName: example-tls

If TLS is enabled for the Ingress, a Secret containing the certificate and key must also be provided:

  apiVersion: v1
  kind: Secret
  metadata:
    name: example-tls
    namespace: foo
  data:
    tls.crt: <base64 encoded cert>
    tls.key: <base64 encoded key>
  type: kubernetes.io/tls
```
