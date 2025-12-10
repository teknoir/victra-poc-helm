### SINKS ###
{{- define "defaultMQTT" }}
    ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),width=[1,{{- template "jpegMQTTWidth" . }}],height=[1,{{- template "jpegMQTTHeight" . }}],pixel-aspect-ratio=1/1
    ! queue ! nvvideoconvert
    ! queue ! nvjpegenc quality={{- template "jpegMQTTQuality" . }} ! appsink sync=0 name=mqttsink
{{- end }}

{{- define "defaultMotionCells" }}
tee.
    ! queue ! nvvideoconvert compute-hw=GPU ! video/x-raw,format=RGB,width=[1,640],height=[1,360],pixel-aspect-ratio=1/1
    ! queue ! motioncells threshold=0.00005 gridx=32 gridy=18 ! fakesink

src.
    ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),width=[1,800],height=[1,600],pixel-aspect-ratio=1/1
    ! queue ! nvvideoconvert
    ! queue ! motioncells threshold=0.00005 gridx=40 gridy=30 ! fakesink

{{- end }}

{{- define "defaultVideoRecorder" }}
tee.
    ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),width={{- template "videoRecorderWidth" . }},height={{- template "videoRecorderHeight" . }}
    ! queue ! nvvideoconvert
    ! queue ! videorate ! video/x-raw,framerate=10/1
    ! queue ! nvvideoconvert
    ! queue ! nvv4l2h264enc copy-meta=true profile=7 control-rate=1 bitrate=3000000 iframeinterval=5 idrinterval=10
    ! queue ! h264parse ! queue ! splitmuxsink sink=nvdsfilesink muxer-properties=properties,streamable=true,moov-relocation=true send-keyframe-requests=true start-index=START_INDEX_RUNTIME_REPLACEMENT location=/app/videos/{{- template "cameraID" . }}_%05d.mp4 max-size-time={{- template "videoRecorderSegmentSizeTime" . }}000000000 max-files={{- template "videoRecorderSegmentCount" . }} name=splitmux
{{- end }}

{{- define "defaultAnnotatingVideoRecorder" }}
tee.
    ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),width={{- template "videoRecorderWidth" . }},height={{- template "videoRecorderHeight" . }}
    ! queue ! nvvideoconvert
    ! queue ! videorate ! video/x-raw,framerate=10/1
    ! queue ! nvvideoconvert
    ! queue ! nvv4l2h264enc copy-meta=true profile=7 control-rate=1 bitrate=3000000 iframeinterval=5
    ! queue ! h264parse ! queue ! splitmuxsink sink=nvdsfilesink muxer-properties=properties,streamable=true,moov-relocation=true send-keyframe-requests=true start-index=START_INDEX_RUNTIME_REPLACEMENT location=/app/videos/{{- template "cameraID" . }}_%05d.mp4 max-size-time={{- template "videoRecorderSegmentSizeTime" . }}000000000 max-files={{- template "videoRecorderSegmentCount" . }} name=splitmux
{{- end }}
