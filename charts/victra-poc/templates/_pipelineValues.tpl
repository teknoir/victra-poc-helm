{{- define "defaultPipelineValues" }}
name: "CHANGE_ME"
camera:
    uri: "CHANGE_ME"
    pipelineValues:
        rtspSrc:
            width: 1920
            height: 1080
        jpegMQTT:
            width: 1920
            height: 1080
            quality: 65
        videoRecorder:
            width: 1920
            height: 1080
            segmentSizeTime: 15
            segmentCount: 2880
{{- end }}

{{- define "cameraID" }}
{{- $default := (include "defaultPipelineValues" . | fromYaml) }}
{{- default $default.name .name -}}
{{- end }}

{{- define "cameraURI" }}
{{- $default := (include "defaultPipelineValues" . | fromYaml) }}
{{- default $default.camera.uri .camera.uri -}}
{{- end }}

{{- define "rtspSrcWidth" }}
{{- $default := (include "defaultPipelineValues" . | fromYaml) }}
{{- default $default.camera.pipelineValues.rtspSrc.width
    (default $default.camera.pipelineValues.rtspSrc
        (default $default.camera.pipelineValues .camera.pipelineValues).rtspSrc).width -}}
{{- end }}

{{- define "rtspSrcHeight" }}
{{- $default := (include "defaultPipelineValues" . | fromYaml) }}
{{- default $default.camera.pipelineValues.rtspSrc.height
    (default $default.camera.pipelineValues.rtspSrc
        (default $default.camera.pipelineValues .camera.pipelineValues).rtspSrc).height -}}
{{- end }}


{{- define "jpegMQTTWidth" -}}
{{- $default := (include "defaultPipelineValues" . | fromYaml) }}
{{- default $default.camera.pipelineValues.jpegMQTT.width
    (default $default.camera.pipelineValues.jpegMQTT
        (default $default.camera.pipelineValues .camera.pipelineValues).jpegMQTT).width -}}
{{- end }}

{{- define "jpegMQTTHeight" }}
{{- $default := (include "defaultPipelineValues" . | fromYaml) }}
{{- default $default.camera.pipelineValues.jpegMQTT.height
    (default $default.camera.pipelineValues.jpegMQTT
        (default $default.camera.pipelineValues .camera.pipelineValues).jpegMQTT).height -}}
{{- end }}

{{- define "jpegMQTTQuality" }}
{{- $default := (include "defaultPipelineValues" . | fromYaml) }}
{{- default $default.camera.pipelineValues.jpegMQTT.quality
    (default $default.camera.pipelineValues.jpegMQTT
        (default $default.camera.pipelineValues .camera.pipelineValues).jpegMQTT).quality -}}
{{- end }}

{{- define "videoRecorderWidth" }}
{{- $default := (include "defaultPipelineValues" . | fromYaml) }}
{{- default $default.camera.pipelineValues.videoRecorder.width
    (default $default.camera.pipelineValues.videoRecorder
        (default $default.camera.pipelineValues .camera.pipelineValues).videoRecorder).width -}}
{{- end }}

{{- define "videoRecorderHeight" }}
{{- $default := (include "defaultPipelineValues" . | fromYaml) }}
{{- default $default.camera.pipelineValues.videoRecorder.height
    (default $default.camera.pipelineValues.videoRecorder
        (default $default.camera.pipelineValues .camera.pipelineValues).videoRecorder).height -}}
{{- end }}

{{- define "videoRecorderSegmentSizeTime" }}
{{- $default := (include "defaultPipelineValues" . | fromYaml) }}
{{- default $default.camera.pipelineValues.videoRecorder.segmentSizeTime
    (default $default.camera.pipelineValues.videoRecorder
        (default $default.camera.pipelineValues .camera.pipelineValues).videoRecorder).segmentSizeTime -}}
{{- end }}

{{- define "videoRecorderSegmentCount" }}
{{- $default := (include "defaultPipelineValues" . | fromYaml) }}
{{- default $default.camera.pipelineValues.videoRecorder.segmentCount
    (default $default.camera.pipelineValues.videoRecorder
        (default $default.camera.pipelineValues .camera.pipelineValues).videoRecorder).segmentCount -}}
{{- end }}
