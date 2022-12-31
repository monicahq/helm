{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "monica.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "monica.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "monica.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "monica.labels" -}}
helm.sh/chart: {{ include "monica.chart" . }}
{{ include "monica.selectorLabels" . }}
{{- if or .Chart.AppVersion .Values.image.tag }}
app.kubernetes.io/version: {{ .Values.image.tag | default .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "monica.selectorLabels" -}}
app.kubernetes.io/name: {{ include "monica.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: app
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "monica.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "monica.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Create a default fully qualified redis app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "monica.redis.fullname" -}}
{{- printf "%s-%s" .Release.Name "redis" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified meilisearch app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "monica.meilisearch.fullname" -}}
{{- printf "%s-%s" .Release.Name "meilisearch" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified memcached app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "monica.memcached.fullname" -}}
{{- printf "%s-%s" .Release.Name "memcached" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "monica.ingress.apiVersion" -}}
{{- if semverCompare "<1.14-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "extensions/v1beta1" -}}
{{- else if semverCompare "<1.19-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "networking.k8s.io/v1beta1" -}}
{{- else -}}
{{- print "networking.k8s.io/v1" -}}
{{- end }}
{{- end -}}

{{/*
Create environment variables used to configure the monica container as well as the cron and schedule containers.
*/}}
{{- define "monica.env" -}}
{{- if .Values.monica.extraEnv }}
{{ toYaml .Values.monica.extraEnv }}
{{- end }}
- name: APP_KEY
  valueFrom:
    secretKeyRef:
      name: {{ template "monica.fullname" . }}
      key: appkey
- name: APP_URL
  value: {{ (printf "https://%s" .Values.monica.host) | quote }}
{{- if .Values.internalDatabase.enabled }}
- name: DB_CONNECTION
  value: sqlite
- name: DB_DATABASE
  value: {{ .Values.internalDatabase.name | quote }}
{{- else if .Values.mariadb.enabled }}
- name: DB_CONNECTION
  value: mysql
- name: DB_HOST
  value: {{ template "mariadb.primary.fullname" .Subcharts.mariadb }}
- name: DB_DATABASE
  value: {{ .Values.mariadb.auth.database | quote }}
- name: DB_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalDatabase.existingSecret.secretName | default (printf "%s-%s" .Release.Name "db") }}
      key: {{ .Values.externalDatabase.existingSecret.usernameKey | default "db-username" }}
- name: DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalDatabase.existingSecret.secretName | default (printf "%s-%s" .Release.Name "db") }}
      key: {{ .Values.externalDatabase.existingSecret.passwordKey | default "db-password" }}
{{- else if .Values.postgresql.enabled }}
- name: DB_CONNECTION
  value: pgsql
- name: DB_HOST
  value: {{ template "postgresql.primary.fullname" .Subcharts.postgresql }}
- name: DB_DATABASE
  {{- if .Values.postgresql.auth.database }}
  value: {{ .Values.postgresql.auth.database | quote }}
  {{ else }}
  value: {{ .Values.postgresql.global.postgresql.auth.database | quote }}
  {{- end }}
- name: DB_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalDatabase.existingSecret.secretName | default (printf "%s-%s" .Release.Name "db") }}
      key: {{ .Values.externalDatabase.existingSecret.usernameKey | default "db-username" }}
- name: DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalDatabase.existingSecret.secretName | default (printf "%s-%s" .Release.Name "db") }}
      key: {{ .Values.externalDatabase.existingSecret.passwordKey | default "db-password" }}
{{- else }}
  {{- if eq .Values.externalDatabase.type "postgresql" }}
- name: DB_CONNECTION
  value: pgsql
  {{- else }}
- name: DB_CONNECTION
  value: mysql
  {{- end }}
- name: DB_HOST
  value: {{ .Values.externalDatabase.host | quote }}
- name: DB_DATABASE
  value: {{ .Values.externalDatabase.database | quote }}
- name: DB_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalDatabase.existingSecret.secretName | default (printf "%s-%s" .Release.Name "db") }}
      key: {{ .Values.externalDatabase.existingSecret.usernameKey | default "db-username" }}
- name: DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalDatabase.existingSecret.secretName | default (printf "%s-%s" .Release.Name "db") }}
      key: {{ .Values.externalDatabase.existingSecret.passwordKey | default "db-password" }}
{{- end }}
{{- if .Values.monica.mail.enabled }}
- name: MAIL_MAILER
  value: smtp
- name: MAIL_HOST
  value: {{ .Values.monica.mail.smtp.host | quote }}
- name: MAIL_PORT
  value: {{ .Values.monica.mail.smtp.port | quote }}
- name: MAIL_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ .Values.monica.existingSecret.secretName | default (include "monica.fullname" .) }}
      key: {{ .Values.monica.existingSecret.mailUsernameKey | default "smtp-username" }}
- name: MAIL_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.monica.existingSecret.secretName | default (include "monica.fullname" .) }}
      key: {{ .Values.monica.existingSecret.mailPasswordKey | default "smtp-password" }}
- name: MAIL_ENCRYPTION
  value: {{ .Values.monica.mail.smtp.encryption | quote }}
- name: MAIL_FROM_ADDRESS
  value: {{ .Values.monica.mail.fromAddress | quote }}
- name: MAIL_REPLY_TO_ADDRESS
  value: {{ .Values.monica.mail.replyToAddress | quote }}
{{- end }}
{{- if .Values.redis.enabled }}
- name: REDIS_HOST
  value: {{ template "monica.redis.fullname" . }}-master
- name: REDIS_PORT
  value: {{ .Values.redis.master.service.ports.redis | quote }}
{{- if .Values.redis.auth.enabled }}
{{- if and .Values.redis.auth.existingSecret .Values.redis.auth.existingSecretPasswordKey }}
- name: REDIS_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.redis.auth.existingSecret }}
      key: {{ .Values.redis.auth.existingSecretPasswordKey }}
{{- else }}
- name: REDIS_PASSWORD
  value: {{ .Values.redis.auth.password }}
{{- end }}
{{- end }}
{{- end }}
{{- if .Values.memcached.enabled }}
- name: MEMCACHED_HOST
  value: {{ template "monica.memcached.fullname" . }}
- name: MEMCACHED_PORT
  value: {{ .Values.memcached.service.ports.memcached  | quote }}
{{- if .Values.memcached.auth.enabled }}
- name: MEMCACHED_USERNAME
  value: {{ .Values.memcached.auth.username }}
{{- if .Values.memcached.auth.existingPasswordSecret }}
- name: MEMCACHED_USERNAME
  valueFrom:
    secretKeyRef:
      name: memcached-password
      key: {{ .Values.memcached.auth.existingPasswordSecret }}
{{- else }}
- name: MEMCACHED_PASSWORD
  value: {{ .Values.memcached.auth.password }}
{{- end }}
{{- end }}
{{- end }}
{{- if .Values.meilisearch.enabled }}
- name: MEILISEARCH_HOST
  value: {{ template "monica.meilisearch.fullname" . }}
{{- if .Values.meilisearch.auth.existingMasterKeySecret }}
- name: MEILISEARCH_KEY
  valueFrom:
    secretKeyRef:
      name: {{ template "monica.meilisearch.fullname" . }}-master-key
      key: MEILI_MASTER_KEY
{{- else }}
{{- end }}
{{- end }}
{{- end -}}

{{/*
Create volume mounts for the monica storagedir.
*/}}
{{- define "monica.volumeMounts" -}}
{{- if .Values.persistence.enabled }}
- name: monica-storage
  mountPath: {{ .Values.monica.storagedir }}
{{- end }}
{{- if .Values.monica.extraVolumeMounts }}
{{ toYaml .Values.monica.extraVolumeMounts }}
{{- end }}
{{- $nginxEnabled := .Values.nginx.enabled -}}
{{- range $key, $value := .Values.monica.phpConfigs }}
- name: monica-phpconfig
  mountPath: {{ $nginxEnabled | ternary (printf "/usr/local/etc/php-fpm.d/%s" $key | quote) (printf "/usr/local/etc/php/conf.d/%s" $key | quote) }}
  subPath: {{ $key }}
{{- end }}
{{- end -}}
