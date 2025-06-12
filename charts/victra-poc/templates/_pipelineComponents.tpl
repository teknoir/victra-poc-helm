{{- define "defaultRTSPSrc" }}
{{/*# Special configuration for Victra cameras, contain data substream, need SPS/PPS headers are injected and it needed byte-stream with au alignment*/}}
{{/*# Also configure the camera to use the dewarper to get the correct views*/}}
rtspsrc location={{- template "cameraURI" . }} protocols=tcp latency=500 name=unmappedsrc
unmappedsrc.
    ! application/x-rtp,media=video,encoding-name=H264
    ! rtpjitterbuffer
    ! rtph264depay
    ! h264parse config-interval=-1 ! video/x-h264,stream-format=byte-stream,alignment=au
    ! queue ! nvv4l2decoder
    ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),width={{- template "rtspSrcWidth" . }},height={{- template "rtspSrcHeight" . }} ! queue name=src
{{- end }}

{{- define "testRTSPSrc" }}
videotestsrc is-live=true
    ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),width={{- template "rtspSrcWidth" . }},height={{- template "rtspSrcHeight" . }} ! queue name=src
{{- end }}

{{- define "defaultNvStreamMux" }}
src.
    ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),width={{- template "nvstreammuxWidth" . }},height={{- template "nvstreammuxHeight" . }}
    ! queue ! nvmux.sink_0 nvstreammux name=nvmux batch-size=4 width={{- template "nvstreammuxWidth" . }} height={{- template "nvstreammuxHeight" . }}
{{- end }}


{{- define "nvdsdewarperNvStreamMux" }}
src.
    ! queue ! nvdewarper config-file=/app/nvdewarper_config/config_nvdewarper.txt
    ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),width={{- template "nvstreammuxWidth" . }},height={{- template "nvstreammuxHeight" . }}
    ! queue ! nvmux.sink_0 nvstreammux name=nvmux batch-size=4 width={{- template "nvstreammuxWidth" . }} height={{- template "nvstreammuxHeight" . }}
{{- end }}


{{- define "defaultNvTracker" }}
    ! queue ! nvtracker tracker-width=640 tracker-height=384 ll-lib-file=/opt/nvidia/deepstream/deepstream/lib/libnvds_nvmultiobjecttracker.so ll-config-file=/trackers/nvidia-tracker/config_tracker_NvDeepSORT.yml compute-hw=2 gpu-id=0
{{- end }}


{{- define "nvdcfNvTrackerResnet50ReId" }}
    ! queue ! nvtracker tracker-width=128 tracker-height=256 input-tensor-meta=0 ll-lib-file=/opt/nvidia/deepstream/deepstream/lib/libnvds_nvmultiobjecttracker.so ll-config-file=/trackers/resnet50-reid-tracker/config.yaml compute-hw=1 gpu-id=0
{{- end }}


{{- define "customStickyNvDeepSortTracker" }}
    ! queue ! nvtracker tracker-width=960 tracker-height=544 input-tensor-meta=0 ll-lib-file=/opt/nvidia/deepstream/deepstream/lib/libnvds_nvmultiobjecttracker.so ll-config-file=/trackers/nvidia-tracker/config_tracker_custom_sticky_NvDeepSORT_b50.yml compute-hw=1 gpu-id=0
{{- end }}

{{- define "defaultNvDCFPerfTracker" }}
    ! queue ! nvtracker tracker-width=960 tracker-height=544 input-tensor-meta=0 ll-lib-file=/opt/nvidia/deepstream/deepstream/lib/libnvds_nvmultiobjecttracker.so ll-config-file=/trackers/nvidia-tracker/config_tracker_NvDCF_perf.yml compute-hw=1 gpu-id=0
{{- end }}

{{- define "defaultNvStreamDemux" }}
    ! queue ! nvstreamdemux name=nvdemux nvdemux.src_0 ! queue ! tee name=tee
tee.
{{- end }}


{{- define "defaultNvInferServer" }}
    ! queue ! nvinferserver name=nvis config-file-path=/models/rtdetr-wwfp/rtdetr-wwfp_config.pbtxt unique-id=2 interval=15
    ! queue ! nvinferserver config-file-path=/models/up-down-classifier/up_down_classifier_config.pbtxt unique-id=5
    ! queue ! nvinferserver config-file-path=/models/resnet50-pose-estimation/resnet50_pose_estimation_config.pbtxt unique-id=200
{{- end }}


{{- define "defaultInference" }}
{{- template "defaultNvStreamMux" . }}
{{- template "defaultNvInferServer" . }}
{{- template "customStickyNvDeepSortTracker" . }}
{{- template "defaultNvStreamDemux" . }}
{{- end }}

{{- define "noInference" }}
{{- template "defaultNvStreamMux" . }}
{{- template "defaultNvStreamDemux" . }}
{{- end }}

{{- define "nvdsdewarperInference" }}
{{- template "nvdsdewarperNvStreamMux" . }}
{{- template "defaultNvInferServer" . }}
{{- template "customStickyNvDeepSortTracker" . }}
{{- template "defaultNvStreamDemux" . }}
{{- end }}

{{- define "defaultNvDsAnalytics" }}
    ! queue ! nvdsanalytics config-file=/app/nvdsanalytics_config/config_nvdsanalytics.txt
    ! queue ! nvdsosd display-bbox=0 display-text=0
{{- end }}

{{- define "defaultMQTT" }}
    ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),width=[1,{{- template "jpegMQTTWidth" . }}],height=[1,{{- template "jpegMQTTHeight" . }}],pixel-aspect-ratio=1/1
    ! queue ! nvvideoconvert
    ! queue ! nvjpegenc quality={{- template "jpegMQTTQuality" . }} ! appsink sync=0 name=mqttsink
{{- end }}

{{- define "defaultMotionCells" }}
tee.
    ! queue ! nvvideoconvert compute-hw=GPU ! video/x-raw,format=RGB,width=[1,640],height=[1,360],pixel-aspect-ratio=1/1
    ! queue ! motioncells threshold=0.00005 gridx=32 gridy=18 ! fakesink
{{- end }}

{{- define "defaultVideoRecorder" }}
tee.
    ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),width={{- template "videoRecorderWidth" . }},height={{- template "videoRecorderHeight" . }}
    ! queue ! nvvideoconvert
    ! queue ! videorate ! video/x-raw,framerate=10/1
    ! queue ! nvvideoconvert
    ! queue ! nvv4l2h264enc copy-meta=true profile=7 control-rate=1 bitrate=3000000 iframeinterval=5
    ! queue ! h264parse ! queue ! splitmuxsink muxer-properties=properties,streamable=true,moov-relocation=true send-keyframe-requests=true location=/app/videos/{{- template "cameraID" . }}_%05d.mp4 max-size-time={{- template "videoRecorderSegmentSizeTime" . }}000000000 max-files={{- template "videoRecorderSegmentCount" . }} name=splitmux
{{- end }}

{{- define "defaultAnnotatingVideoRecorder" }}
tee.
    ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),width={{- template "videoRecorderWidth" . }},height={{- template "videoRecorderHeight" . }}
    ! queue ! nvvideoconvert
    ! queue ! videorate ! video/x-raw,framerate=10/1
    ! queue ! nvvideoconvert
    ! queue ! nvv4l2h264enc copy-meta=true profile=7 control-rate=1 bitrate=3000000 iframeinterval=5
    ! queue ! h264parse ! queue ! splitmuxsink sink=nvdsfilesink muxer-properties=properties,streamable=true,moov-relocation=true send-keyframe-requests=true location=/app/videos/{{- template "cameraID" . }}_%05d.mp4 max-size-time={{- template "videoRecorderSegmentSizeTime" . }}000000000 max-files={{- template "videoRecorderSegmentCount" . }} name=splitmux
{{- end }}
