# Monica Helm Charts

[Helm](https://helm.sh) repo for different charts related to Monica which can be installed on [Kubernetes](https://kubernetes.io)

### Add Helm repository

To install the repo just run:

```bash
helm repo add monica https://monicahq.github.io/helm/
helm repo update
```

### Helm Charts

* [monica](https://monicahq.github.io/helm/)

  ```sh
  helm install my-release monica/monica
  ```

  ```sh
  helm upgrade --install monica monica/monica --create-namespace --namespace monica
  ```

For more information, please checkout the chart level [README.md](./charts/monica/README.md).
