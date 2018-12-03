{{- define "name" -}}
{{- $name := default Chart.Name .Values.nameOverride -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "fullname" -}}
{{- $fullname := default Chart.Name .Values.nameOverride -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}