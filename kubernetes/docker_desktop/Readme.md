# Kubernetes on Docker Desktop

## Metrics Server

* Metrics server for k8s on Docker Desktop requires below flag to container args on its pod spec

```yaml
- --kubelet-insecure-tls
```

* `k apply -f metrics_server.yaml`

---
