# Contributing

## Testing

Install prerequisites:
- [helm](https://helm.sh/)
- [helm chart testing](https://github.com/helm/chart-testing)
- [minikube](https://minikube.sigs.k8s.io/docs/start/)

Start minikube:

```sh
minikube start
```

Start chart-testing:

```sh
ct install --config ct.yaml --helm-extra-args '--timeout 200s'
```

You can also add a yaml file in the `charts/monica/ci` directory to test the chart with different values.

## Pre-commit

This repository uses [pre-commit](https://pre-commit.com/) to run checks before each commit.

To install pre-commit, run:

```sh
pre-commit install
```
