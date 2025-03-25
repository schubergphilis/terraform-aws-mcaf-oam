locals {
  link_configuration_enabled         = local.link_configuration_log_enabled || local.link_configuration_metrics_enabled
  link_configuration_log_enabled     = length(var.log_group_config.explicit_log_groups) > 0 || length(var.log_group_config.wildcard_log_groups) > 0
  link_configuration_metrics_enabled = length(local.metric_aws_namespaces_include) > 0 || var.metric_config.include_custom_namespaces
  logs_enabled                       = var.resource_types.logs || local.link_configuration_log_enabled
  metrics_enabled                    = var.resource_types.metrics || local.link_configuration_metrics_enabled

  enabled_resource_types = [
    for key, value in {
      "AWS::ApplicationInsights::Application" = var.resource_types.insights
      "AWS::CloudWatch::Metric"               = local.metrics_enabled
      "AWS::InternetMonitor::Monitor"         = var.resource_types.internet_monitors
      "AWS::Logs::LogGroup"                   = local.logs_enabled
      "AWS::XRay::Trace"                      = var.resource_types.traces
    } : key if value
  ]

  log_group_query = join(" OR ", concat(
    length(var.log_group_config.explicit_log_groups) > 0 ?
    ["LogGroupName IN (${join(", ", [for lg in var.log_group_config.explicit_log_groups : format("'%s'", lg)])})"] : [],
    [for pattern in var.log_group_config.wildcard_log_groups : "LogGroupName LIKE '${pattern}'"]
  ))

  # ordering here looks off, but is in line with:
  # https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html
  metric_aws_namespaces_map = {
    "AWS/AmplifyHosting"                    = var.metric_config.aws_namespaces.amplify_hosting
    "AWS/ApiGateway"                        = var.metric_config.aws_namespaces.api_gateway
    "AWS/AppFlow"                           = var.metric_config.aws_namespaces.app_flow
    "AWS/MGN"                               = var.metric_config.aws_namespaces.mgn
    "AWS/AppRunner"                         = var.metric_config.aws_namespaces.app_runner
    "AWS/AppStream"                         = var.metric_config.aws_namespaces.app_stream
    "AWS/AppSync"                           = var.metric_config.aws_namespaces.app_sync
    "AWS/Athena"                            = var.metric_config.aws_namespaces.athena
    "AWS/Backup"                            = var.metric_config.aws_namespaces.backup
    "AWS/Bedrock"                           = var.metric_config.aws_namespaces.bedrock
    "AWS/Billing"                           = var.metric_config.aws_namespaces.billing
    "AWS/Braket/By Device"                  = var.metric_config.aws_namespaces.braket_by_device
    "AWS/CertificateManager"                = var.metric_config.aws_namespaces.certificate_manager
    "AWS/ACMPrivateCA"                      = var.metric_config.aws_namespaces.acm_private_ca
    "AWS/Chatbot"                           = var.metric_config.aws_namespaces.chatbot
    "AWS/ChimeVoiceConnector"               = var.metric_config.aws_namespaces.chime_voice_connector
    "AWS/ChimeSDK"                          = var.metric_config.aws_namespaces.chime_sdk
    "AWS/ClientVPN"                         = var.metric_config.aws_namespaces.client_vpn
    "AWS/CloudFront"                        = var.metric_config.aws_namespaces.cloud_front
    "AWS/CloudHSM"                          = var.metric_config.aws_namespaces.cloud_hsm
    "AWS/CloudSearch"                       = var.metric_config.aws_namespaces.cloud_search
    "AWS/CloudTrail"                        = var.metric_config.aws_namespaces.cloud_trail
    "CWAgent"                               = var.metric_config.aws_namespaces.cw_agent
    "ApplicationSignals"                    = var.metric_config.aws_namespaces.application_signals
    "AWS/CloudWatch/MetricStreams"          = var.metric_config.aws_namespaces.cloudwatch_metric_streams
    "AWS/RUM"                               = var.metric_config.aws_namespaces.rum
    "CloudWatchSynthetics"                  = var.metric_config.aws_namespaces.cloudwatch_synthetics
    "AWS/Logs"                              = var.metric_config.aws_namespaces.logs
    "AWS/CodeBuild"                         = var.metric_config.aws_namespaces.code_build
    "AWS/CodeWhisperer"                     = var.metric_config.aws_namespaces.code_whisperer
    "AWS/Cognito"                           = var.metric_config.aws_namespaces.cognito
    "AWS/Comprehend"                        = var.metric_config.aws_namespaces.comprehend
    "AWS/Config"                            = var.metric_config.aws_namespaces.config
    "AWS/Connect"                           = var.metric_config.aws_namespaces.connect
    "AWS/DataLifecycleManager"              = var.metric_config.aws_namespaces.data_lifecyle_manager
    "AWS/DataSync"                          = var.metric_config.aws_namespaces.data_sync
    "AWS/DevOps-Guru"                       = var.metric_config.aws_namespaces.dev_ops_guru
    "AWS/DMS"                               = var.metric_config.aws_namespaces.database_migration_service
    "AWS/DX"                                = var.metric_config.aws_namespaces.direct_connect
    "AWS/DirectoryService"                  = var.metric_config.aws_namespaces.directory_service
    "AWS/DocDB"                             = var.metric_config.aws_namespaces.document_db
    "AWS/DynamoDB"                          = var.metric_config.aws_namespaces.dynamo_db
    "AWS/DAX"                               = var.metric_config.aws_namespaces.dynamo_db_accelerator
    "AWS/EC2"                               = var.metric_config.aws_namespaces.ec2
    "AWS/ElasticGPUs"                       = var.metric_config.aws_namespaces.elastic_gpus
    "AWS/EC2Spot"                           = var.metric_config.aws_namespaces.ec2_spot
    "AWS/AutoScaling"                       = var.metric_config.aws_namespaces.auto_scaling
    "AWS/ElasticBeanstalk"                  = var.metric_config.aws_namespaces.elastic_beanstalk
    "AWS/EBS"                               = var.metric_config.aws_namespaces.ebs
    "AWS/ECR"                               = var.metric_config.aws_namespaces.ecr
    "AWS/ECS"                               = var.metric_config.aws_namespaces.ecs
    "ECS/ContainerInsights"                 = var.metric_config.aws_namespaces.ecs_container_insights
    "AWS/ECS/ManagedScaling"                = var.metric_config.aws_namespaces.ecs_managed_scaling
    "AWS/EFS"                               = var.metric_config.aws_namespaces.efs
    "AWS/ElasticInference"                  = var.metric_config.aws_namespaces.elastic_interface
    "ContainerInsights"                     = var.metric_config.aws_namespaces.container_insights
    "AWS/ApplicationELB"                    = var.metric_config.aws_namespaces.application_elb
    "AWS/ApplicationELB"                    = var.metric_config.aws_namespaces.network_elb
    "AWS/GatewayELB"                        = var.metric_config.aws_namespaces.gateway_elb
    "AWS/ELB"                               = var.metric_config.aws_namespaces.elb
    "AWS/ElasticTranscoder"                 = var.metric_config.aws_namespaces.elastic_transcoder
    "AWS/ElastiCache"                       = var.metric_config.aws_namespaces.elasti_cache
    "AWS/ES"                                = var.metric_config.aws_namespaces.es
    "AWS/ElasticMapReduce"                  = var.metric_config.aws_namespaces.elastic_map_reduce
    "AWS/MediaConnect"                      = var.metric_config.aws_namespaces.media_connect
    "AWS/MediaConvert"                      = var.metric_config.aws_namespaces.media_convert
    "AWS/MediaLive"                         = var.metric_config.aws_namespaces.media_live
    "AWS/MediaPackage"                      = var.metric_config.aws_namespaces.media_package
    "AWS/MediaStore"                        = var.metric_config.aws_namespaces.media_store
    "AWS/MediaStore"                        = var.metric_config.aws_namespaces.media_tailor
    "AWS/SMSVoice"                          = var.metric_config.aws_namespaces.sms_voice
    "AWS/SocialMessaging"                   = var.metric_config.aws_namespaces.social_messaging
    "AWS/Events"                            = var.metric_config.aws_namespaces.events
    "AWS/FSx"                               = var.metric_config.aws_namespaces.fsx
    "AWS/GameLift"                          = var.metric_config.aws_namespaces.game_lift
    "AWS/GlobalAccelerator"                 = var.metric_config.aws_namespaces.global_accelerator
    "Glue"                                  = var.metric_config.aws_namespaces.glue
    "AWS/GroundStation"                     = var.metric_config.aws_namespaces.ground_station
    "AWS/HealthLake"                        = var.metric_config.aws_namespaces.health_lake
    "AWS/Inspector"                         = var.metric_config.aws_namespaces.inspector
    "AWS/IVS"                               = var.metric_config.aws_namespaces.ivs
    "AWS/IVSChat"                           = var.metric_config.aws_namespaces.ivs_chat
    "AWS/IoT"                               = var.metric_config.aws_namespaces.iot
    "AWS/IoTAnalytics"                      = var.metric_config.aws_namespaces.iot_analytics
    "AWS/IoTFleetWise"                      = var.metric_config.aws_namespaces.iot_fleet_wise
    "AWS/IoTSiteWise"                       = var.metric_config.aws_namespaces.iot_site_wise
    "AWS/IoTTwinMaker"                      = var.metric_config.aws_namespaces.iot_twin_maker
    "AWS/KMS"                               = var.metric_config.aws_namespaces.kms
    "AWS/Cassandra"                         = var.metric_config.aws_namespaces.cassandra
    "AWS/KinesisAnalytics"                  = var.metric_config.aws_namespaces.kinesis_analytics
    "AWS/Firehose"                          = var.metric_config.aws_namespaces.firehose
    "AWS/Kinesis"                           = var.metric_config.aws_namespaces.kinesis
    "AWS/KinesisVideo"                      = var.metric_config.aws_namespaces.kinesis_video
    "AWS/Lambda"                            = var.metric_config.aws_namespaces.lambda
    "AWS/Lex"                               = var.metric_config.aws_namespaces.lex
    "AWSLicenseManager/licenseUsage"        = var.metric_config.aws_namespaces.license_manager_license_usage
    "AWS/LicenseManager/LinuxSubscriptions" = var.metric_config.aws_namespaces.license_manager_linux_subscriptions
    "AWS/Location"                          = var.metric_config.aws_namespaces.location
    "AWS/lookoutequipment"                  = var.metric_config.aws_namespaces.lookout_equipment
    "AWS/LookoutMetrics"                    = var.metric_config.aws_namespaces.lookout_metrics
    "AWS/LookoutVision"                     = var.metric_config.aws_namespaces.lookout_vision
    "AWS/ML"                                = var.metric_config.aws_namespaces.ml
    "AWS/managedblockchain"                 = var.metric_config.aws_namespaces.managed_blockchain
    "AWS/Prometheus"                        = var.metric_config.aws_namespaces.prometheus
    "AWS/Kafka"                             = var.metric_config.aws_namespaces.kafka
    "AWS/KafkaConnect"                      = var.metric_config.aws_namespaces.kafka_connect
    "AWS/MWAA"                              = var.metric_config.aws_namespaces.mwaa
    "AWS/MemoryDB"                          = var.metric_config.aws_namespaces.memory_db
    "AWS/AmazonMQ"                          = var.metric_config.aws_namespaces.amazon_mq
    "AWS/Neptune"                           = var.metric_config.aws_namespaces.neptune
    "AWS/NetworkFirewall"                   = var.metric_config.aws_namespaces.network_firewall
    "AWS/NetworkManager"                    = var.metric_config.aws_namespaces.network_manager
    "AWS/NimbleStudio"                      = var.metric_config.aws_namespaces.nimble_studio
    "AWS/Omics"                             = var.metric_config.aws_namespaces.omics
    "AWS/OpsWorks"                          = var.metric_config.aws_namespaces.ops_works
    "AWS/Outposts"                          = var.metric_config.aws_namespaces.outposts
    "AWS/PanoramaDeviceMetrics"             = var.metric_config.aws_namespaces.panorama_device_metrics
    "AWS/Personalize"                       = var.metric_config.aws_namespaces.personalize
    "AWS/Pinpoint"                          = var.metric_config.aws_namespaces.pinpoint
    "AWS/Polly"                             = var.metric_config.aws_namespaces.polly
    "AWS/PrivateLinkEndpoints"              = var.metric_config.aws_namespaces.private_link_endpoints
    "AWS/PrivateLinkServices"               = var.metric_config.aws_namespaces.private_link_services
    "AWS/Private5G"                         = var.metric_config.aws_namespaces.private_5g
    "AWS/QLDB"                              = var.metric_config.aws_namespaces.qldb
    "AWS/QuickSight"                        = var.metric_config.aws_namespaces.quick_sight
    "AWS/Redshift"                          = var.metric_config.aws_namespaces.redshift
    "AWS/RDS"                               = var.metric_config.aws_namespaces.rds
    "AWS/Rekognition"                       = var.metric_config.aws_namespaces.rekognition
    "AWS/rePostPrivate"                     = var.metric_config.aws_namespaces.re_post_private
    "AWS/RoboMaker"                         = var.metric_config.aws_namespaces.robomaker
    "AWS/Route53"                           = var.metric_config.aws_namespaces.route53
    "AWS/Route53RecoveryReadiness"          = var.metric_config.aws_namespaces.route53_recovery_readiness
    "AWS/SageMaker"                         = var.metric_config.aws_namespaces.sage_maker
    "AWS/SageMaker/ModelBuildingPipeline"   = var.metric_config.aws_namespaces.sage_maker_model_building_pipeline
    "AWS/SecretsManager"                    = var.metric_config.aws_namespaces.secrets_manager
    "AWS/SecurityLake"                      = var.metric_config.aws_namespaces.security_lake
    "AWS/ServiceCatalog"                    = var.metric_config.aws_namespaces.service_catalog
    "AWS/DDoSProtection"                    = var.metric_config.aws_namespaces.ddos_protection
    "AWS/SES"                               = var.metric_config.aws_namespaces.ses
    "AWS/simspaceweaver"                    = var.metric_config.aws_namespaces.sim_space_weaver
    "AWS/SNS"                               = var.metric_config.aws_namespaces.sns
    "AWS/SQS"                               = var.metric_config.aws_namespaces.sqs
    "AWS/S3"                                = var.metric_config.aws_namespaces.s3
    "AWS/S3/Storage-Lens"                   = var.metric_config.aws_namespaces.s3_storage_lens
    "AWS/SWF"                               = var.metric_config.aws_namespaces.swf
    "AWS/States"                            = var.metric_config.aws_namespaces.states
    "AWS/StorageGateway"                    = var.metric_config.aws_namespaces.storage_gateway
    "AWS/SSM-RunCommand"                    = var.metric_config.aws_namespaces.ssm_run_command
    "AWS/Textract"                          = var.metric_config.aws_namespaces.textract
    "AWS/Timestream"                        = var.metric_config.aws_namespaces.timestream
    "AWS/Transfer"                          = var.metric_config.aws_namespaces.transfer
    "AWS/Transcribe"                        = var.metric_config.aws_namespaces.transcribe
    "AWS/Translate"                         = var.metric_config.aws_namespaces.translate
    "AWS/TrustedAdvisor"                    = var.metric_config.aws_namespaces.trusted_advisor
    "AWS/NATGateway"                        = var.metric_config.aws_namespaces.nat_gateway
    "AWS/TransitGateway"                    = var.metric_config.aws_namespaces.transit_gateway
    "AWS/VPN"                               = var.metric_config.aws_namespaces.vpn
    "AWS/IPAM"                              = var.metric_config.aws_namespaces.ipam
    "WAF"                                   = var.metric_config.aws_namespaces.waf
    "AWS/WAFV2"                             = var.metric_config.aws_namespaces.waf_v2
    "AWS/WorkMail"                          = var.metric_config.aws_namespaces.work_mail
    "AWS/WorkSpaces"                        = var.metric_config.aws_namespaces.work_spaces
    "AWS/WorkSpacesWeb"                     = var.metric_config.aws_namespaces.work_spaces_web
  }

  metric_aws_namespaces_include = [
    for key, value in local.metric_aws_namespaces_map : key if value
  ]

  metric_aws_namespaces_no_prefix = [
    for key, value in local.metric_aws_namespaces_map : key if !startswith(key, "AWS/")
  ]

  metric_query = join(" OR ", concat(
    length(local.metric_aws_namespaces_include) > 0 ? ["Namespace IN (${join(", ", [for ns in local.metric_aws_namespaces_include : format("'%s'", ns)])})"] : [],
    var.metric_config.include_custom_namespaces ? ["(Namespace NOT IN (${join(", ", [for key in local.metric_aws_namespaces_no_prefix : format("'%s'", key)])}) AND Namespace NOT LIKE 'AWS/%')"] : []
  ))
}
