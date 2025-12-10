### INFERENCE ###
{{- define "defaultNvInferServer" }}
    ! queue ! nvinferserver name=nvis config-file-path=/models/rtdetr-wwfp/rtdetr-wwfp_config.pbtxt unique-id=2 interval=15
    ! queue ! nvinferserver config-file-path=/models/up-down-classifier/up_down_classifier_config.pbtxt unique-id=5
    ! queue ! nvinferserver config-file-path=/models/resnet50-pose-estimation/resnet50_pose_estimation_config.pbtxt unique-id=200
{{- end }}
