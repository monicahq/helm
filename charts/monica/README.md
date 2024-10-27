# monica

![Version: 1.0.12](https://img.shields.io/badge/Version-1.0.12-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 5.0.0](https://img.shields.io/badge/AppVersion-5.0.0-informational?style=flat-square)

A Helm chart for Kubernetes to install Monica

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm repo add monica https://monicahq.github.io/helm/
helm install my-release monica/monica
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| MonicaHQ |  | <https://github.com/monicahq/monica> |
| asbiin | <alexis@saettler.org> |  |

## Source Code

* <https://github.com/monicahq/helm>

## Requirements

Kubernetes: `>=1.16.0-0`

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
| affinity | object | `{}` | Affinity for pod assignment |
| deploymentAnnotations | object | `{}` | Annotations to be added at 'service' level |
| externalDatabase.database | string | `"monica"` | Database name |
| externalDatabase.enabled | bool | `false` | Enable external database |
| externalDatabase.existingSecret.enabled | bool | `false` | Use an existing secret. If enabled set: `secretName`, `usernameKey`, `passwordKey` |
| externalDatabase.host | string | `nil` | Database host |
| externalDatabase.password | string | `"secret"` | Database password |
| externalDatabase.type | string | `"mysql"` | Database type. Supported database engines: `mysql` or `postgresql` |
| externalDatabase.user | string | `"monica"` | Database user |
| fullnameOverride | string | `""` | Override the fullname of the chart |
| hpa.cputhreshold | int | `60` |  |
| hpa.enabled | bool | `false` | Enable Horizontal Pod Autoscaler |
| hpa.maxPods | int | `10` |  |
| hpa.minPods | int | `1` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/monicahq/monica-next"` |  |
| image.tag | string | `"main"` |  |
| ingress.annotations | object | `{}` | An array of service annotations |
| ingress.className | string | `nil` | Name of the ingress class to use |
| ingress.enabled | bool | `false` | Enable ingress controller resource |
| ingress.labels | object | `{}` | An array of service labels |
| ingress.path | string | `"/"` | The Path to use in Ingress' paths |
| ingress.pathType | string | `"Prefix"` | The PathType to use in Ingress' paths |
| internalDatabase.enabled | bool | `true` | Enable internal (SQLite) database |
| internalDatabase.name | string | `"/var/www/html/database/monica.sqlite"` | Database fullpath file |
| lifecycle | object | `{}` | Allow configuration of lifecycle hooks. ref: https://kubernetes.io/docs/tasks/configure-pod-container/attach-handler-lifecycle-event/ |
| livenessProbe.enabled | bool | `true` | Enable liveness probe |
| livenessProbe.failureThreshold | int | `3` |  |
| livenessProbe.initialDelaySeconds | int | `10` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| mariadb.architecture | string | `"standalone"` | MariaDB architecture: `standalone` or `replication` |
| mariadb.auth.database | string | `"monica"` | Database name |
| mariadb.auth.password | string | `"secret"` | Database password |
| mariadb.auth.username | string | `"monica"` | Database user |
| mariadb.enabled | bool | `false` | Whether to deploy a mariadb server to satisfy the applications database requirements. To use an external database set this to false and configure the externalDatabase parameters |
| mariadb.primary.persistence.accessMode | string | `"ReadWriteOnce"` | Access Mode for the PVC |
| mariadb.primary.persistence.enabled | bool | `false` | Enable MariaDB persistence using Persistent Volume Claims |
| mariadb.primary.persistence.existingClaim | string | `nil` | Use an existing Persistent Volume Claim (must be created ahead of time) |
| mariadb.primary.persistence.size | string | `"8Gi"` | PVC Storage Request |
| mariadb.primary.persistence.storageClass | string | `nil` | Storage class of backing PVC |
| meilisearch.enabled | bool | `false` | Enable Meilisearch. Use with `SCOUT_DRIVER=meilisearch` and `SCOUT_QUEUE=true` variables. |
| meilisearch.environment.MEILI_ENV | string | `"production"` |  |
| memcached.auth.enabled | bool | `true` | Enable memcached authentication |
| memcached.auth.password | string | `"secret"` | Memcached password |
| memcached.auth.username | string | `"monica"` | Memcached user |
| memcached.containerSecurityContext | object | `{}` |  |
| memcached.enabled | bool | `false` | Enable Memcached. Use with a `CACHE_STORE=memcached` variable (can also be used for `SESSION_DRIVER`). |
| monica.containerPort | int | `80` | Customize container port |
| monica.cronjob.enabled | bool | `false` | Enable cronjob to execute monica scheduled tasks |
| monica.cronjob.lifecycle | object | `{}` | Allow configuration of lifecycle hooks. ref: https://kubernetes.io/docs/tasks/configure-pod-container/attach-handler-lifecycle-event/ |
| monica.existingSecret.enabled | bool | `false` | Use an existing secret. If enabled, you need to set: `secretName`, `appKey`, `mailUsernameKey`, `mailPasswordKey` |
| monica.extraEnv | list | `[]` | Extra environment variables |
| monica.extraInitContainers | list | `[]` | Extra init containers that runs before pods start. |
| monica.extraSidecarContainers | list | `[]` | Extra sidecar containers. |
| monica.extraVolumeMounts | list | `[]` | Extra mounts for the pods. |
| monica.extraVolumes | list | `[]` | Extra volumes for the pods. |
| monica.host | string | `"monica.kube.home"` | Application URL |
| monica.mail.enabled | bool | `false` | Enable email service |
| monica.mail.fromAddress | string | `"user"` | Email `from` address |
| monica.mail.replyToAddress | string | `"user"` | Email `reply-to` address |
| monica.mail.smtp.encryption | string | `"tls"` | SMTP encryption |
| monica.mail.smtp.host | string | `"domain.com"` | SMTP host |
| monica.mail.smtp.password | string | `"pass"` | SMTP password |
| monica.mail.smtp.port | int | `465` | SMTP port |
| monica.mail.smtp.username | string | `"user"` | SMTP username |
| monica.phpConfigs | object | `{}` | PHP Configuration files. Will be injected in /usr/local/etc/php/conf.d for apache image and in /usr/local/etc/php-fpm.d when nginx.enabled: true |
| monica.queue.enabled | bool | `false` | Enable queue job to execute monica background tasks. Use in addition to a `QUEUE_CONNECTION` variable. |
| monica.queue.lifecycle | object | `{}` | Allow configuration of lifecycle hooks. ref: https://kubernetes.io/docs/tasks/configure-pod-container/attach-handler-lifecycle-event/ |
| monica.storagedir | string | `"/var/www/html/storage"` | Monica storage directory |
| monica.strategy | object | `{"type":"Recreate"}` | Strategy used to replace old pods. IMPORTANT: use with care, it is suggested to leave as that for upgrade purposes. ref: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy |
| nameOverride | string | `""` | Add a suffix to the name of the chart |
| nginx.config.custom | string | `nil` | Custom nginx configuration |
| nginx.config.default | bool | `true` | Generates the default nginx config |
| nginx.containerPort | int | `80` | Customize container port |
| nginx.enabled | bool | `false` | Enable nginx. You need to set an fpm version of the image for monica if you want to use nginx. |
| nginx.image.pullPolicy | string | `"IfNotPresent"` |  |
| nginx.image.repository | string | `"nginx"` |  |
| nginx.image.tag | string | `"alpine"` |  |
| nginx.resources | object | `{}` | nginx resources definition (limits, requests) |
| nodeSelector | object | `{}` | Node labels for pod assignment |
| persistence.accessMode | string | `"ReadWriteOnce"` | Persistent Volume Access Mode |
| persistence.annotations | object | `{}` | Persistent Volume Claim annotations |
| persistence.enabled | bool | `false` | Enable Monica persistence using Persistent Volume Claims |
| persistence.existingClaim | string | `nil` | A manually managed Persistent Volume and Claim  Requires persistence.enabled: true  If defined, PVC must be created manually before volume will be bound |
| persistence.size | string | `"4Gi"` | Persistent Volume Storage Request |
| persistence.storageClass | string | `nil` | Persistent Volume Storage Class If defined, storageClassName: <storageClass> If set to "-", storageClassName: "", which disables dynamic provisioning If undefined (the default) or set to null, no storageClassName spec is   set, choosing the default provisioner. (gp2 on AWS, standard on   GKE, AWS & OpenStack) |
| podAnnotations | object | `{}` | Annotations to be added at 'pod' level |
| podLabels | object | `{}` | Labels to be added at 'pod' level |
| postgresql.enabled | bool | `false` | Whether to deploy a postgresql server to satisfy the applications database requirements. To use an external database set this to false and configure the externalDatabase parameters |
| postgresql.global.postgresql.auth.database | string | `"monica"` | Database name |
| postgresql.global.postgresql.auth.password | string | `"secret"` | Database password |
| postgresql.global.postgresql.auth.username | string | `"monica"` | Database user |
| postgresql.primary.persistence.enabled | bool | `false` | Enable PostgreSQL persistence using Persistent Volume Claims |
| postgresql.primary.persistence.existingClaim | string | `nil` | Use an existing Persistent Volume Claim (must be created ahead of time) |
| postgresql.primary.persistence.storageClass | string | `nil` | Storage class of backing PVC |
| rbac.create | bool | `true` | Specifies whether RBAC resources should be created |
| readinessProbe.enabled | bool | `true` | Enable readiness probe |
| readinessProbe.failureThreshold | int | `3` |  |
| readinessProbe.initialDelaySeconds | int | `10` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| redis.auth.enabled | bool | `true` | Enable redis authentication |
| redis.auth.password | string | `"secret"` | Redis password |
| redis.enabled | bool | `false` | Enable Redis. Use with a `QUEUE_CONNECTION=redis` variable (can also be used for `CACHE_STORE` and `SESSION_DRIVER`). |
| replicaCount | int | `1` | Number of replicas to be deployed |
| resources | object | `{}` | Define resources requests and limits for the pod (limits, requests) |
| service.annotations | object | `{}` | Service annotations |
| service.loadBalancerIP | string | `""` | Load Balancer IP (optional, only works with service.type LoadBalancer) |
| service.nodePort | string | `nil` | Node Port (optional, only works with service.type NodePort) |
| service.port | int | `8080` | Service port |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `nil` | The name of the service account to use.  If not set and create is true, a name is generated using the fullname template |
| startupProbe.enabled | bool | `false` | Enable startup probe |
| startupProbe.failureThreshold | int | `30` |  |
| startupProbe.initialDelaySeconds | int | `30` |  |
| startupProbe.periodSeconds | int | `10` |  |
| startupProbe.successThreshold | int | `1` |  |
| startupProbe.timeoutSeconds | int | `5` |  |
| tolerations | list | `[]` | Tolerations for pod assignment |

## Database

By default, the chart uses a SQLite database. If you want to use a different database, set the `internalDatabase.enabled` parameters to `false` in your `values.yaml`.

```yaml
internalDatabase:
  enabled: false
```

You can also use an external database by setting the `externalDatabase.enabled` parameters to `true` in your `values.yaml`.

```yaml
internalDatabase:
  enabled: false
externalDatabase:
  enabled: true
  type: mysql
  host: myhost.test
  user: monica
  password: secret
  database: monica
```

Or you can use a mariadb database by setting the `mariadb.enabled` parameters to `true` in your `values.yaml`.

```yaml
internalDatabase:
  enabled: false
mariadb:
  enabled: true
```

## Cron job

Monica requires a cron job to run reminders and other [scheduled](https://laravel.com/docs/11.x/scheduling) tasks. You can enable the cron job by setting the `monica.cronjob.enabled` parameters to `true` in your `values.yaml`.

```yaml
monica:
  cronJob:
    enabled: true
```

## Queue worker

Monica works better with a [queue](https://laravel.com/docs/11.x/queues) worker. You can enable the queue worker by setting the `monica.queue.enabled` parameters to `true` in your `values.yaml`.
You can use the `database` for `QUEUE_CONNECTION`, but other options exists.

```yaml
monica:
  queue:
    enabled: true
  extraEnv:
    - name: QUEUE_CONNECTION
      value: database
```

## Add environment variables

To add environment variables to the monica container, set the `monica.extraEnv` parameters in your `values.yaml`.

Example:

```yaml
monica:
  extraEnv:
    - name: QUEUE_CONNECTION
      value: redis
    - name: CACHE_STORE
      value: memcached
    - name: SCOUT_DRIVER
      value: meilisearch
    - name: SCOUT_QUEUE
      value: "true"
    - name: PHP_UPLOAD_LIMIT
      value: 10G
```

## Using nginx

To use nginx instead of apache to serve monica, set the following parameters in your `values.yaml`:

```yaml
# This uses the fpm flavor of the monica image
image:
  tag: main-fpm

# this deploys an nginx container within the monica pod
nginx
  enabled: true
```

## Php configuration

You may want special [`php.ini`](https://www.php.net/manual/en/ini.list.php) values. For instance, perhaps your setup requires a bit more memory. You can add additional `php.ini` files in the values.yaml by providing `monica.phpConfigs.NAME_OF_FILE`.

Example:

```yaml
monica:
  phpConfigs:
    zz-error.ini: |-
      error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT
      display_errors = Off
```

> [!Note]
> Be sure to prefix your file name with `zz` to ensure it is loaded at the end.

## HPA (Clustering)

If you want to have multiple Monica containers, regardless of dynamic or static sizes, you need to use shared persistence between the containers.

Minimum cluster compatible persistence settings:
```yaml
persistence:
  enabled: true
  accessMode: ReadWriteMany
```

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)