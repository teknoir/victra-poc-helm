### SOURCE ###
{{- define "removeDataSubstreamRTSPSrc" }}
{{/*# Special configuration for Victra cameras, contain data substream, need SPS/PPS headers are injected and it needed byte-stream with au alignment*/}}
{{/*# Also configure the camera to use the dewarper to get the correct views*/}}
rtspsrc location={{- template "cameraURI" . }} protocols=tcp latency=500 name=unmappedsrc
unmappedsrc.
    ! application/x-rtp,media=video,encoding-name=H264
    ! rtpjitterbuffer
    ! rtph264depay
    ! h264parse config-interval=-1 ! video/x-h264,stream-format=byte-stream,alignment=au
    ! queue ! nvv4l2decoder
    ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),format=RGBA,width={{- template "rtspSrcWidth" . }},height={{- template "rtspSrcHeight" . }} ! tee name=src
{{- end }}

{{- define "nvurisrcbinRTSPSrc" }}
nvurisrcbin uri={{- template "cameraURI" . }} select-rtp-protocol=4 rtsp-reconnect-interval=10 rtsp-reconnect-attempts=4 latency=500
    ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),format=RGBA,width={{- template "rtspSrcWidth" . }},height={{- template "rtspSrcHeight" . }} ! tee name=src
{{- end }}

{{- define "uridecodeRTSPSrc" }}
uridecodebin3 uri={{- template "cameraURI" . }}
    ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),format=RGBA,width={{- template "rtspSrcWidth" . }},height={{- template "rtspSrcHeight" . }} ! tee name=src
{{- end }}

{{- define "testRTSPSrc" }}
videotestsrc is-live=true
    ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),format=RGBA,width={{- template "rtspSrcWidth" . }},height={{- template "rtspSrcHeight" . }} ! tee name=src
{{- end }}

{{- define "defaultRTSPSrc" }}
{{- template "removeDataSubstreamRTSPSrc" . }}
{{- end }}
