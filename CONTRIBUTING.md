# Contributing

## Testing

Install prerequisites:
- [helm](https://helm.sh/)
- [helm chart testing](https://github.com/helm/chart-testing)
- [minikube](https://minikube.sigs.k8s.io/docs/start/)
- [pre-commit](https://pre-commit.com/)
- [helm-docs](https://github.com/norwoodj/helm-docs#installation)
- [helm values schema](https://github.com/losisin/helm-values-schema-json)

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
pre-commit install-hooks
```

## Helm docs

To generate the documentation for the chart, run:

```sh
helm-docs
```

# Helm values schema

To generate the values schema for the chart, run:

```sh
helm schema --values charts/monica/values.yaml --output charts/monica/values.schema.json --indent 2
```
