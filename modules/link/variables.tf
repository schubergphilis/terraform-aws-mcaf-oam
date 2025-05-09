variable "label_template" {
  type        = string
  description = "Human-readable name to use to identify this source account when you are viewing data from it in the monitoring account."
  default     = "$AccountName"
}

variable "log_group_config" {
  type = object({
    explicit_log_groups = optional(list(string), [])
    wildcard_log_groups = optional(list(string), [])
  })
  description = "Specify explicit log groups or wildcard log groups for LogGroupConfiguration."
  default     = {}
}

variable "metric_config" {
  type = object({
    aws_namespaces = optional(object({
      # ordering here looks off, but is in line with:
      # https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html
      amplify_hosting                     = optional(bool, false)
      api_gateway                         = optional(bool, false)
      app_flow                            = optional(bool, false)
      mgn                                 = optional(bool, false)
      app_runner                          = optional(bool, false)
      app_stream                          = optional(bool, false)
      app_sync                            = optional(bool, false)
      athena                              = optional(bool, false)
      backup                              = optional(bool, false)
      bedrock                             = optional(bool, false)
      billing                             = optional(bool, false)
      braket_by_device                    = optional(bool, false)
      certificate_manager                 = optional(bool, false)
      acm_private_ca                      = optional(bool, false)
      chatbot                             = optional(bool, false)
      chime_voice_connector               = optional(bool, false)
      chime_sdk                           = optional(bool, false)
      client_vpn                          = optional(bool, false)
      cloud_front                         = optional(bool, false)
      cloud_hsm                           = optional(bool, false)
      cloud_search                        = optional(bool, false)
      cloud_trail                         = optional(bool, false)
      cw_agent                            = optional(bool, false)
      application_signals                 = optional(bool, false)
      cloudwatch_metric_streams           = optional(bool, false)
      rum                                 = optional(bool, false)
      cloudwatch_synthetics               = optional(bool, false)
      logs                                = optional(bool, false)
      code_build                          = optional(bool, false)
      code_whisperer                      = optional(bool, false)
      cognito                             = optional(bool, false)
      comprehend                          = optional(bool, false)
      config                              = optional(bool, false)
      connect                             = optional(bool, false)
      data_lifecyle_manager               = optional(bool, false)
      data_sync                           = optional(bool, false)
      dev_ops_guru                        = optional(bool, false)
      database_migration_service          = optional(bool, false)
      direct_connect                      = optional(bool, false)
      directory_service                   = optional(bool, false)
      document_db                         = optional(bool, false)
      dynamo_db                           = optional(bool, false)
      dynamo_db_accelerator               = optional(bool, false)
      ec2                                 = optional(bool, false)
      elastic_gpus                        = optional(bool, false)
      ec2_spot                            = optional(bool, false)
      auto_scaling                        = optional(bool, false)
      elastic_beanstalk                   = optional(bool, false)
      ebs                                 = optional(bool, false)
      ecr                                 = optional(bool, false)
      ecs                                 = optional(bool, false)
      ecs_container_insights              = optional(bool, false)
      ecs_managed_scaling                 = optional(bool, false)
      efs                                 = optional(bool, false)
      elastic_interface                   = optional(bool, false)
      container_insights                  = optional(bool, false)
      application_elb                     = optional(bool, false)
      network_elb                         = optional(bool, false)
      gateway_elb                         = optional(bool, false)
      elb                                 = optional(bool, false)
      elastic_transcoder                  = optional(bool, false)
      elasti_cache                        = optional(bool, false)
      es                                  = optional(bool, false)
      elastic_map_reduce                  = optional(bool, false)
      media_connect                       = optional(bool, false)
      media_convert                       = optional(bool, false)
      media_live                          = optional(bool, false)
      media_package                       = optional(bool, false)
      media_store                         = optional(bool, false)
      media_tailor                        = optional(bool, false)
      sms_voice                           = optional(bool, false)
      social_messaging                    = optional(bool, false)
      events                              = optional(bool, false)
      fsx                                 = optional(bool, false)
      game_lift                           = optional(bool, false)
      global_accelerator                  = optional(bool, false)
      glue                                = optional(bool, false)
      ground_station                      = optional(bool, false)
      health_lake                         = optional(bool, false)
      inspector                           = optional(bool, false)
      ivs                                 = optional(bool, false)
      ivs_chat                            = optional(bool, false)
      iot                                 = optional(bool, false)
      iot_analytics                       = optional(bool, false)
      iot_fleet_wise                      = optional(bool, false)
      iot_site_wise                       = optional(bool, false)
      iot_twin_maker                      = optional(bool, false)
      kms                                 = optional(bool, false)
      cassandra                           = optional(bool, false)
      kinesis_analytics                   = optional(bool, false)
      firehose                            = optional(bool, false)
      kinesis                             = optional(bool, false)
      kinesis_video                       = optional(bool, false)
      lambda                              = optional(bool, false)
      lex                                 = optional(bool, false)
      license_manager_license_usage       = optional(bool, false)
      license_manager_linux_subscriptions = optional(bool, false)
      location                            = optional(bool, false)
      lookout_equipment                   = optional(bool, false)
      lookout_metrics                     = optional(bool, false)
      lookout_vision                      = optional(bool, false)
      ml                                  = optional(bool, false)
      managed_blockchain                  = optional(bool, false)
      prometheus                          = optional(bool, false)
      kafka                               = optional(bool, false)
      kafka_connect                       = optional(bool, false)
      mwaa                                = optional(bool, false)
      memory_db                           = optional(bool, false)
      amazon_mq                           = optional(bool, false)
      neptune                             = optional(bool, false)
      network_firewall                    = optional(bool, false)
      network_manager                     = optional(bool, false)
      nimble_studio                       = optional(bool, false)
      omics                               = optional(bool, false)
      ops_works                           = optional(bool, false)
      outposts                            = optional(bool, false)
      panorama_device_metrics             = optional(bool, false)
      personalize                         = optional(bool, false)
      pinpoint                            = optional(bool, false)
      polly                               = optional(bool, false)
      private_link_endpoints              = optional(bool, false)
      private_link_services               = optional(bool, false)
      private_5g                          = optional(bool, false)
      qldb                                = optional(bool, false)
      quick_sight                         = optional(bool, false)
      redshift                            = optional(bool, false)
      rds                                 = optional(bool, false)
      rekognition                         = optional(bool, false)
      re_post_private                     = optional(bool, false)
      robomaker                           = optional(bool, false)
      route53                             = optional(bool, false)
      route53_recovery_readiness          = optional(bool, false)
      sage_maker                          = optional(bool, false)
      sage_maker_model_building_pipeline  = optional(bool, false)
      secrets_manager                     = optional(bool, false)
      security_lake                       = optional(bool, false)
      service_catalog                     = optional(bool, false)
      ddos_protection                     = optional(bool, false)
      ses                                 = optional(bool, false)
      sim_space_weaver                    = optional(bool, false)
      sns                                 = optional(bool, false)
      sqs                                 = optional(bool, false)
      s3                                  = optional(bool, false)
      s3_storage_lens                     = optional(bool, false)
      swf                                 = optional(bool, false)
      states                              = optional(bool, false)
      storage_gateway                     = optional(bool, false)
      ssm_run_command                     = optional(bool, false)
      textract                            = optional(bool, false)
      timestream                          = optional(bool, false)
      transfer                            = optional(bool, false)
      transcribe                          = optional(bool, false)
      translate                           = optional(bool, false)
      trusted_advisor                     = optional(bool, false)
      nat_gateway                         = optional(bool, false)
      transit_gateway                     = optional(bool, false)
      vpn                                 = optional(bool, false)
      ipam                                = optional(bool, false)
      waf                                 = optional(bool, false)
      waf_v2                              = optional(bool, false)
      work_mail                           = optional(bool, false)
      work_spaces                         = optional(bool, false)
      work_spaces_web                     = optional(bool, false)
    }), {})
    include_custom_namespaces = optional(bool, false)
  })
  description = "Specify AWS namespaces to include in MetricConfiguration and whether to include custom namespaces."
  default     = {}
}

variable "resource_types" {
  type = object({
    insights          = optional(bool, false)
    internet_monitors = optional(bool, false)
    logs              = optional(bool, false)
    metrics           = optional(bool, false)
    traces            = optional(bool, false)
  })
  description = "Specify resource types for the link"
  default     = {}
}

variable "sink_arn" {
  type        = string
  description = "Arn of sink to link to."
}

variable "tags" {
  type        = map(string)
  description = "Tags to be added to the specific resource"
  default     = {}
}
