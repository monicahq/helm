{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "monica.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "monica.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "monica.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified redis app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "monica.redis.fullname" -}}
{{- printf "%s-%s" .Release.Name "redis" | trunc 63 | trimSuffix "-" -}}
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
- name: DB_USER
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
- name: DB_USER
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
- name: DB_USER
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
{{- end -}}

{{/*
Create volume mounts for the monica storagedir.
*/}}
{{- define "monica.volumeMounts" -}}
{{- if .Values.persistence.enabled }}
- name: monica-data
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
