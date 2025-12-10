### PIPELINES ###
{{- define "defaultInference" }}
{{- template "defaultNvStreamMux" . }}
{{- template "defaultNvInferServer" . }}
{{- template "defaultNvTracker" . }}
{{- template "defaultNvStreamDemux" . }}
{{- end }}


{{- define "defaultInferenceAccuracyTracker" }}
{{- template "defaultNvStreamMux" . }}
{{- template "defaultNvInferServer" . }}
{{- template "defaultNvDCFAccuracyTracker" . }}
{{- template "defaultNvStreamDemux" . }}
{{- end }}


{{- define "defaultInferenceReIdSWINb1024Tracker" }}
{{- template "defaultNvStreamMux" . }}
{{- template "defaultNvInferServer" . }}
{{- template "nvdcfNvReIdSWINb1024Tracker" . }}
{{- template "defaultNvStreamDemux" . }}
{{- end }}


{{- define "noInference" }}
{{- template "defaultNvStreamMux" . }}
{{- template "defaultNvStreamDemux" . }}
{{- end }}


{{- define "nvdsdewarperInference" }}
{{- template "nvdsdewarperNvStreamMux" . }}
{{- template "defaultNvInferServer" . }}
{{- template "defaultNvTracker" . }}
{{- template "defaultNvStreamDemux" . }}
{{- end }}


{{- define "nvdsdewarperInferenceAccuracyTracker" }}
{{- template "nvdsdewarperNvStreamMux" . }}
{{- template "defaultNvInferServer" . }}
{{- template "defaultNvDCFAccuracyTracker" . }}
{{- template "defaultNvStreamDemux" . }}
{{- end }}


{{- define "nvdsdewarperInferenceReIdSWINb1024Tracker" }}
{{- template "nvdsdewarperNvStreamMux" . }}
{{- template "defaultNvInferServer" . }}
{{- template "nvdcfNvReIdSWINb1024Tracker" . }}
{{- template "defaultNvStreamDemux" . }}
{{- end }}


