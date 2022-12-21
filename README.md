# Monica Helm Charts

[Helm](https://helm.sh) repo for Monica.

## Add the monica repo as follows:

```console
helm repo add monica https://monicahq.github.io/helm
helm repo update
```

You can then run `helm search repo monica` to see the charts.

## Helm Charts

[monica](https://monicahq.github.io/helm)

### To install the monica chart:

```console
helm install my-release monica/monica
```

### To uninstall the chart:

```console
helm delete my-release
```
