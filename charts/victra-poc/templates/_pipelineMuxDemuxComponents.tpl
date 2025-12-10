### MUX / DEWARPER ###
{{- define "defaultNvStreamMux" }}
src.
    ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),format=RGBA,width={{- template "nvstreammuxWidth" . }},height={{- template "nvstreammuxHeight" . }}
    ! queue ! nvmux.sink_0 nvstreammux name=nvmux batch-size=4 width={{- template "nvstreammuxWidth" . }} height={{- template "nvstreammuxHeight" . }}
{{- end }}


{{- define "nvdsdewarperNvStreamMux" }}
src.
    ! queue ! nvdewarper config-file=/app/nvdewarper_config/config_nvdewarper.txt
    ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),format=RGBA,width={{- template "nvstreammuxWidth" . }},height={{- template "nvstreammuxHeight" . }}
    ! queue ! nvmux.sink_0 nvstreammux name=nvmux batch-size=4 width={{- template "nvstreammuxWidth" . }} height={{- template "nvstreammuxHeight" . }}
{{- end }}


### DEMUX ###
{{- define "defaultNvStreamDemux" }}
    ! queue ! nvstreamdemux name=nvdemux nvdemux.src_0 ! queue ! tee name=tee
tee.
{{- end }}



{{/*          peripherals:*/}}
{{/*            - name: Teknoir-NVR-Vid#1*/}}
{{/*              id: teknoir-nvr-vid1*/}}
{{/*            - name: Teknoir-NVR-Vid#2*/}}
{{/*              id: teknoir-nvr-vid2*/}}
{{/*            - name: Teknoir-NVR-Vid#3*/}}
{{/*              id: teknoir-nvr-vid3*/}}
{{/*            - name: Teknoir-NVR-Vid#4*/}}
{{/*              id: teknoir-nvr-vid4*/}}
{{/*          pipeline: |-*/}}
{{/*            rtspsrc location={{.uri}} protocols=tcp latency=500*/}}
{{/*            ! application/x-rtp,media=video,encoding-name=H264*/}}
{{/*            ! rtpjitterbuffer*/}}
{{/*            ! rtph264depay*/}}
{{/*            ! h264parse config-interval=-1 ! video/x-h264,stream-format=byte-stream,alignment=au*/}}
{{/*            ! queue ! nvv4l2decoder*/}}
{{/*            ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),width=4000,height=3000 ! queue ! nvvideoconvert ! tee name=src*/}}
{{/*            src.*/}}
{{/*            ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),width=[1,800],height=[1,600],pixel-aspect-ratio=1/1*/}}
{{/*            ! queue ! nvvideoconvert*/}}
{{/*            ! queue ! motioncells threshold=0.00005 gridx=40 gridy=30 ! fakesink*/}}
{{/*            src.*/}}
{{/*            ! queue ! nvdewarper config-file=/app/nvdewarper_config/nvdewarper_1_config.txt*/}}
{{/*            ! queue ! nvmux.sink_0 nvstreammux name=nvmux batch-size=4 width=1920 height=1080*/}}
{{/*            ! queue ! nvinferserver name=nvis config-file-path=/models/rtdetr-wwfp/rtdetr-wwfp_config.pbtxt unique-id=2 interval=0*/}}
{{/*            ! queue ! nvtracker tracker-width=128 tracker-height=256 ll-lib-file=/opt/nvidia/deepstream/deepstream/lib/libnvds_nvmultiobjecttracker.so ll-config-file=/trackers/nvidia-tracker/config_tracker_NvDCF_accuracy.yml compute-hw=1 gpu-id=0*/}}
{{/*            ! queue ! nvstreamdemux name=nvdemux*/}}
{{/*            nvdemux.src_0*/}}
{{/*            ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),width=[1,1920],height=[1,1080],pixel-aspect-ratio=1/1*/}}
{{/*            ! queue ! tee name=src_0*/}}
{{/*            src_0.*/}}
{{/*            ! queue ! nvvideoconvert*/}}
{{/*            ! queue ! nvjpegenc quality=75 ! nvdsmqttsink*/}}
{{/*            src_0.*/}}
{{/*            ! queue ! nvvideoconvert*/}}
{{/*            ! queue ! videorate ! video/x-raw,framerate=10/1*/}}
{{/*            ! queue ! nvvideoconvert*/}}
{{/*            ! queue ! nvv4l2h264enc copy-meta=true profile=7 control-rate=1 bitrate=3000000 iframeinterval=5 idrinterval=10*/}}
{{/*            ! queue ! h264parse ! queue ! splitmuxsink sink=nvdsfilesink muxer-properties=properties,streamable=true,moov-relocation=true send-keyframe-requests=true location=/app/videos/{{(index .peripherals 0).id}}_%05d.mp4 max-size-time=15000000000 max-files=28*/}}
{{/*            src.*/}}
{{/*            ! queue ! nvdewarper config-file=/app/nvdewarper_config/nvdewarper_2_config.txt*/}}
{{/*            ! queue ! nvmux.sink_1*/}}
{{/*            nvdemux.src_1*/}}
{{/*            ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),width=[1,1920],height=[1,1080],pixel-aspect-ratio=1/1*/}}
{{/*            ! queue ! tee name=src_1*/}}
{{/*            src_1.*/}}
{{/*            ! queue ! nvvideoconvert*/}}
{{/*            ! queue ! nvjpegenc quality=75 ! nvdsmqttsink*/}}
{{/*            src_1.*/}}
{{/*            ! queue ! nvvideoconvert*/}}
{{/*            ! queue ! videorate ! video/x-raw,framerate=10/1*/}}
{{/*            ! queue ! nvvideoconvert*/}}
{{/*            ! queue ! nvv4l2h264enc copy-meta=true profile=7 control-rate=1 bitrate=3000000 iframeinterval=5 idrinterval=10*/}}
{{/*            ! queue ! h264parse ! queue ! splitmuxsink sink=nvdsfilesink muxer-properties=properties,streamable=true,moov-relocation=true send-keyframe-requests=true location=/app/videos/{{(index .peripherals 1).id}}_%05d.mp4 max-size-time=15000000000 max-files=28*/}}
{{/*            src.*/}}
{{/*            ! queue ! nvdewarper config-file=/app/nvdewarper_config/nvdewarper_3_config.txt*/}}
{{/*            ! queue ! nvmux.sink_2*/}}
{{/*            nvdemux.src_2*/}}
{{/*            ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),width=[1,1920],height=[1,1080],pixel-aspect-ratio=1/1*/}}
{{/*            ! queue ! tee name=src_2*/}}
{{/*            src_2.*/}}
{{/*            ! queue ! nvvideoconvert*/}}
{{/*            ! queue ! nvjpegenc quality=75 ! nvdsmqttsink*/}}
{{/*            src_2.*/}}
{{/*            ! queue ! nvvideoconvert*/}}
{{/*            ! queue ! videorate ! video/x-raw,framerate=10/1*/}}
{{/*            ! queue ! nvvideoconvert*/}}
{{/*            ! queue ! nvv4l2h264enc copy-meta=true profile=7 control-rate=1 bitrate=3000000 iframeinterval=5 idrinterval=10*/}}
{{/*            ! queue ! h264parse ! queue ! splitmuxsink sink=nvdsfilesink muxer-properties=properties,streamable=true,moov-relocation=true send-keyframe-requests=true location=/app/videos/{{(index .peripherals 2).id}}_%05d.mp4 max-size-time=15000000000 max-files=28*/}}
{{/*            src.*/}}
{{/*            ! queue ! nvdewarper config-file=/app/nvdewarper_config/nvdewarper_4_config.txt*/}}
{{/*            ! queue ! nvmux.sink_3*/}}
{{/*            nvdemux.src_3*/}}
{{/*            ! queue ! nvvideoconvert ! video/x-raw(memory:NVMM),width=[1,1920],height=[1,1080],pixel-aspect-ratio=1/1*/}}
{{/*            ! queue ! tee name=src_3*/}}
{{/*            src_3.*/}}
{{/*            ! queue ! nvvideoconvert*/}}
{{/*            ! queue ! nvjpegenc quality=75 ! nvdsmqttsink*/}}
{{/*            src_3.*/}}
{{/*            ! queue ! nvvideoconvert*/}}
{{/*            ! queue ! videorate ! video/x-raw,framerate=10/1*/}}
{{/*            ! queue ! nvvideoconvert*/}}
{{/*            ! queue ! nvv4l2h264enc copy-meta=true profile=7 control-rate=1 bitrate=3000000 iframeinterval=5 idrinterval=10*/}}
{{/*            ! queue ! h264parse ! queue ! splitmuxsink sink=nvdsfilesink muxer-properties=properties,streamable=true,moov-relocation=true send-keyframe-requests=true location=/app/videos/{{(index .peripherals 3).id}}_%05d.mp4 max-size-time=15000000000 max-files=28*/}}
