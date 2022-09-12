

helm install -f tenant1.yml stateful-web ./stateful-web --namespace=tenant1 --create-namespace --dry-run

helm install -f tenant2.yml stateful-web ./stateful-web --namespace=tenant2 --create-namespace --dry-run

helm status app -n tenant1

helm ls --all-namespaces

helm ls app -n tenant1

helm upgrade -f ./app/values.yaml --set frontend.replicas=1 ./app --namespace=tenant1 --create-namespace --dry-run

helm upgrade -f ./app/values.yaml --set frontend.replicas=1 app ./app --namespace=tenant1 --create-namespace

# Values.yaml = Default. Overrides per env if needed
helm upgrade -f ./app/values.yaml ./tenant1.yaml ./app --namespace=tenant1 --create-namespace --dry-run

More Commands: https://helm.sh/docs/helm/helm_upgrade/