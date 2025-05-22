{{- define "testPipeline" }}
{{- template "testRTSPSrc" . }}
{{- template "noInference" . }}
{{- template "defaultMQTT" . }}
{{- end }}

{{- define "defaultPipeline" }}
{{- template "defaultRTSPSrc" . }}
{{- template "defaultInference" . }}
{{- template "defaultMQTT" . }}
{{- template "defaultMotionCells" . }}
{{- template "defaultVideoRecorder" . }}
{{- end }}


{{- define "nvdsanalyticsPipeline" }}
{{- template "defaultRTSPSrc" . }}
{{- template "defaultInference" . }}
{{- template "defaultNvDsAnalytics" . }}
{{- template "defaultMQTT" . }}
{{- template "defaultMotionCells" . }}
{{- template "defaultVideoRecorder" . }}
{{- end }}


{{- define "default360Pipeline" }}
{{- template "defaultRTSPSrc" . }}
{{- template "nvdsdewarperInference" . }}
{{- template "defaultMQTT" . }}
{{- template "defaultMotionCells" . }}
{{- template "defaultVideoRecorder" . }}
{{- end }}


{{- define "nvdsanalytics360Pipeline" }}
{{- template "defaultRTSPSrc" . }}
{{- template "nvdsdewarperInference" . }}
{{- template "defaultNvDsAnalytics" . }}
{{- template "defaultMQTT" . }}
{{- template "defaultMotionCells" . }}
{{- template "defaultVideoRecorder" . }}
{{- end }}