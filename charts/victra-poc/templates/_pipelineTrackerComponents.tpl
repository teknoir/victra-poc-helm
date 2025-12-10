### TRACKERS ###
{{- define "defaultNvDeepSORTTracker" }}
    ! queue ! nvtracker tracker-width=640 tracker-height=384 ll-lib-file=/opt/nvidia/deepstream/deepstream/lib/libnvds_nvmultiobjecttracker.so ll-config-file=/trackers/nvidia-tracker/config_tracker_NvDeepSORT.yml compute-hw=1 gpu-id=0
{{- end }}


{{- define "defaultNvDCFPerfTracker" }}
    ! queue ! nvtracker tracker-width=960 tracker-height=544 input-tensor-meta=0 ll-lib-file=/opt/nvidia/deepstream/deepstream/lib/libnvds_nvmultiobjecttracker.so ll-config-file=/trackers/nvidia-tracker/config_tracker_NvDCF_perf.yml compute-hw=1 gpu-id=0
{{- end }}


{{- define "defaultNvDCFAccuracyTracker" }}
    ! queue ! nvtracker tracker-width=128 tracker-height=256 input-tensor-meta=0 ll-lib-file=/opt/nvidia/deepstream/deepstream/lib/libnvds_nvmultiobjecttracker.so ll-config-file=/trackers/nvidia-tracker/config_tracker_NvDCF_accuracy.yml compute-hw=1 gpu-id=0
{{- end }}


{{- define "nvdcfNvTrackerResnet50ReId" }}
    ! queue ! nvtracker tracker-width=128 tracker-height=256 input-tensor-meta=0 ll-lib-file=/opt/nvidia/deepstream/deepstream/lib/libnvds_nvmultiobjecttracker.so ll-config-file=/trackers/resnet50-reid-tracker/config.yaml compute-hw=1 gpu-id=0
{{- end }}


{{- define "nvdcfNvReIdSWINb1024Tracker" }}
    ! queue ! nvtracker tracker-width=128 tracker-height=256 ll-lib-file=/opt/nvidia/deepstream/deepstream/lib/libnvds_nvmultiobjecttracker.so ll-config-file=/trackers/reid-swinb-1024-tracker/config.yaml compute-hw=1 gpu-id=0
{{- end }}


{{- define "defaultNvTracker" }}
{{- template "defaultNvDCFPerfTracker" . }}
{{- end }}
