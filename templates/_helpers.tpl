{{/*
Expand the name of the chart.
*/}}
{{- define "sre-app.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a fully qualified name for the release.
*/}}
{{- define "sre-app.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name }}-{{ .Chart.Name }}
{{- end }}
{{- end }}

{{/*
Common labels to be used in all resources.
*/}}
{{- define "sre-app.labels" -}}
app: {{ include "sre-app.name" . }}
chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
release: {{ .Release.Name }}
heritage: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for deployments and services.
*/}}
{{- define "sre-app.selectorLabels" -}}
app: {{ include "sre-app.name" . }}
release: {{ .Release.Name }}
{{- end }}

{{/*
Define the Service Account Name.
*/}}
{{- define "sre-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "sre-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
default
{{- end }}
{{- end }}
