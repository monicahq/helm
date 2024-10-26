# monica

![Version: 1.0.11](https://img.shields.io/badge/Version-1.0.11-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 5.0.0](https://img.shields.io/badge/AppVersion-5.0.0-informational?style=flat-square)

A Helm chart for Kubernetes to install Monica

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| MonicaHQ |  | <https://github.com/monicahq/monica> |
| asbiin | <alexis@saettler.org> |  |

## Source Code

* <https://github.com/monicahq/helm>

## Requirements

Kubernetes: `>=1.31.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://meilisearch.github.io/meilisearch-kubernetes | meilisearch | 0.10.* |
| oci://registry-1.docker.io/bitnamicharts | mariadb | 19.1.* |
| oci://registry-1.docker.io/bitnamicharts | memcached | 7.5.* |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 16.0.* |
| oci://registry-1.docker.io/bitnamicharts | redis | 20.2.* |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| deploymentAnnotations | object | `{}` |  |
| externalDatabase.database | string | `"monica"` |  |
| externalDatabase.enabled | bool | `false` |  |
| externalDatabase.existingSecret.enabled | bool | `false` |  |
| externalDatabase.host | string | `nil` |  |
| externalDatabase.password | string | `"secret"` |  |
| externalDatabase.type | string | `"mysql"` |  |
| externalDatabase.user | string | `"monica"` |  |
| fullnameOverride | string | `""` |  |
| hpa.cputhreshold | int | `60` |  |
| hpa.enabled | bool | `false` |  |
| hpa.maxPods | int | `10` |  |
| hpa.minPods | int | `1` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/monicahq/monica-next"` |  |
| image.tag | string | `"main"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.labels | object | `{}` |  |
| ingress.path | string | `"/"` |  |
| ingress.pathType | string | `"Prefix"` |  |
| internalDatabase.enabled | bool | `true` |  |
| internalDatabase.name | string | `"/var/www/html/database/monica.sqlite"` |  |
| lifecycle | object | `{}` |  |
| livenessProbe.enabled | bool | `true` |  |
| livenessProbe.failureThreshold | int | `3` |  |
| livenessProbe.initialDelaySeconds | int | `10` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| mariadb.architecture | string | `"standalone"` |  |
| mariadb.auth.database | string | `"monica"` |  |
| mariadb.auth.password | string | `"secret"` |  |
| mariadb.auth.username | string | `"monica"` |  |
| mariadb.enabled | bool | `false` |  |
| mariadb.primary.persistence.accessMode | string | `"ReadWriteOnce"` |  |
| mariadb.primary.persistence.enabled | bool | `false` |  |
| mariadb.primary.persistence.size | string | `"8Gi"` |  |
| meilisearch.enabled | bool | `false` |  |
| meilisearch.environment.MEILI_ENV | string | `"production"` |  |
| memcached.auth.enabled | bool | `true` |  |
| memcached.auth.password | string | `"secret"` |  |
| memcached.auth.username | string | `"monica"` |  |
| memcached.containerSecurityContext.readOnlyRootFilesystem | bool | `false` |  |
| memcached.enabled | bool | `false` |  |
| monica.cronjob.enabled | bool | `false` |  |
| monica.cronjob.lifecycle | object | `{}` |  |
| monica.existingSecret.enabled | bool | `false` |  |
| monica.extraEnv | string | `nil` |  |
| monica.extraInitContainers | list | `[]` |  |
| monica.extraSidecarContainers | list | `[]` |  |
| monica.extraVolumeMounts | string | `nil` |  |
| monica.extraVolumes | string | `nil` |  |
| monica.host | string | `"monica.kube.home"` |  |
| monica.mail.enabled | bool | `false` |  |
| monica.mail.fromAddress | string | `"user"` |  |
| monica.mail.replyToAddress | string | `"user"` |  |
| monica.mail.smtp.encryption | string | `"tls"` |  |
| monica.mail.smtp.host | string | `"domain.com"` |  |
| monica.mail.smtp.password | string | `"pass"` |  |
| monica.mail.smtp.port | int | `465` |  |
| monica.mail.smtp.username | string | `"user"` |  |
| monica.phpConfigs | object | `{}` |  |
| monica.queue.enabled | bool | `false` |  |
| monica.queue.lifecycle | object | `{}` |  |
| monica.queue.priorityClassName | string | `"important"` |  |
| monica.queue.terminationGracePeriodSeconds | int | `20` |  |
| monica.storagedir | string | `"/var/www/html/storage"` |  |
| monica.strategy.type | string | `"Recreate"` |  |
| nameOverride | string | `""` |  |
| nginx.config.default | bool | `true` |  |
| nginx.containerPort | int | `80` |  |
| nginx.enabled | bool | `false` |  |
| nginx.image.pullPolicy | string | `"IfNotPresent"` |  |
| nginx.image.repository | string | `"nginx"` |  |
| nginx.image.tag | string | `"alpine"` |  |
| nginx.resources | object | `{}` |  |
| nodeSelector | object | `{}` |  |
| persistence.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.annotations | object | `{}` |  |
| persistence.enabled | bool | `false` |  |
| persistence.size | string | `"4Gi"` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| postgresql.enabled | bool | `false` |  |
| postgresql.global.postgresql.auth.database | string | `"monica"` |  |
| postgresql.global.postgresql.auth.password | string | `"secret"` |  |
| postgresql.global.postgresql.auth.username | string | `"monica"` |  |
| postgresql.primary.persistence.enabled | bool | `false` |  |
| rbac.create | bool | `true` |  |
| readinessProbe.enabled | bool | `true` |  |
| readinessProbe.failureThreshold | int | `3` |  |
| readinessProbe.initialDelaySeconds | int | `10` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| redis.auth.enabled | bool | `true` |  |
| redis.auth.password | string | `"secret"` |  |
| redis.enabled | bool | `false` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| service.annotations | object | `{}` |  |
| service.loadBalancerIP | string | `""` |  |
| service.nodePort | string | `nil` |  |
| service.port | int | `8080` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `nil` |  |
| startupProbe.enabled | bool | `false` |  |
| startupProbe.failureThreshold | int | `30` |  |
| startupProbe.initialDelaySeconds | int | `30` |  |
| startupProbe.periodSeconds | int | `10` |  |
| startupProbe.successThreshold | int | `1` |  |
| startupProbe.timeoutSeconds | int | `5` |  |
| tests.unitTests.resources.limits.cpu | string | `"200m"` |  |
| tests.unitTests.resources.limits.memory | string | `"256Mi"` |  |
| tests.unitTests.resources.requests.cpu | string | `"100m"` |  |
| tests.unitTests.resources.requests.memory | string | `"128Mi"` |  |
| tolerations | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
