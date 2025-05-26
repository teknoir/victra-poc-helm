{{- define "defaultNvDewarperValues" }}
nvdewarperValues:
    width: 1920
    height: 1080
    pitch: 0
    yaw: 0
    roll: 0
{{- end }}

{{- define "nvdewarperWidth" }}
{{- $default := (include "defaultNvDewarperValues" . | fromYaml) }}
{{- default $default.nvdewarperValues.width (default $default.nvdewarperValues .nvdewarperValues).width -}}
{{- end }}

{{- define "nvdewarperHeight" }}
{{- $default := (include "defaultNvDewarperValues" . | fromYaml) }}
{{- default $default.nvdewarperValues.height (default $default.nvdewarperValues .nvdewarperValues).height -}}
{{- end }}

{{- define "nvdewarperPitch" }}
{{- $default := (include "defaultNvDewarperValues" . | fromYaml) }}
{{- default $default.nvdewarperValues.pitch (default $default.nvdewarperValues .nvdewarperValues).pitch -}}
{{- end }}

{{- define "nvdewarperYaw" }}
{{- $default := (include "defaultNvDewarperValues" . | fromYaml) }}
{{- default $default.nvdewarperValues.yaw (default $default.nvdewarperValues .nvdewarperValues).yaw -}}
{{- end }}

{{- define "nvdewarperRoll" }}
{{- $default := (include "defaultNvDewarperValues" . | fromYaml) }}
{{- default $default.nvdewarperValues.roll (default $default.nvdewarperValues .nvdewarperValues).roll -}}
{{- end }}


{{- define "360NvDeWarper" }}
[property]
enable=1
source-id=0
output-width={{- template "nvdewarperWidth" . }}
output-height={{- template "nvdewarperHeight" . }}
num-batch-buffers=1
[surface0]
surface-index=0
projection-type=1
width={{- template "nvdewarperWidth" . }}
height={{- template "nvdewarperHeight" . }}
rot-axes=ZXY
pitch={{- template "nvdewarperPitch" . }}
yaw={{- template "nvdewarperYaw" . }}
roll={{- template "nvdewarperRoll" . }}
src-fov=180
src-x0=2000
src-y0=1500
focal-length=960
distortion=0;0;0;0
{{- end }}

