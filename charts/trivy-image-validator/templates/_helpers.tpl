{{/*
Expand the name of the chart.
*/}}
{{- define "trivy-image-validator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "trivy-image-validator.fullname" -}}
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
{{- define "trivy-image-validator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Get the namespace name. */}}
{{- define "trivy-image-validator.namespace" -}}
{{- if .Values.createSelfSignedCert }}
    {{- .Release.Namespace -}}
{{- else -}}
    {{- .Values.namespace -}}
{{- end -}}
{{- end -}}

{{/* Create the name of the service to use */}}
{{- define "trivy-image-validator.serviceName" -}}
{{- if .Values.createSelfSignedCert }}
    {{- printf "%s-svc" (include "trivy-image-validator.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- else -}}
    {{- .Values.serviceName -}}
{{- end -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "trivy-image-validator.labels" -}}
helm.sh/chart: {{ include "trivy-image-validator.chart" . }}
{{ include "trivy-image-validator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "trivy-image-validator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "trivy-image-validator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "trivy-image-validator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "trivy-image-validator.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
