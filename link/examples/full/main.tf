terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.72"
    }
  }
  required_version = ">= 1.9"
}

provider "aws" {
  region = "eu-west-1"
}

module "oam_link" {
  source = "../.."

  # provide the sink arn, required
  sink_arn = "arn:aws:oam:eu-west-1:123456789012:sink/12345678-aaaa-bbbb-cccc-123456789012"

  # forward logs from 2 specific log groups + all lambda logs groups
  log_group_config = {
    explicit_log_groups = ["This-Log-Group", "Other-Log-Group"]
    wildcard_log_groups = ["aws/lambda/%"]
  }

  # enable all AWS metrics and all custom metrics
  metric_config = {
    aws_namespaces = {
      amplify_hosting                     = true
      api_gateway                         = true
      app_flow                            = true
      mgn                                 = true
      app_runner                          = true
      app_stream                          = true
      app_sync                            = true
      athena                              = true
      backup                              = true
      bedrock                             = true
      billing                             = true
      braket_by_device                    = true
      certificate_manager                 = true
      acm_private_ca                      = true
      chatbot                             = true
      chime_voice_connector               = true
      chime_sdk                           = true
      client_vpn                          = true
      cloud_front                         = true
      cloud_hsm                           = true
      cloud_search                        = true
      cloud_trail                         = true
      cw_agent                            = true
      application_signals                 = true
      cloudwatch_metric_streams           = true
      rum                                 = true
      cloudwatch_synthetics               = true
      logs                                = true
      code_build                          = true
      code_whisperer                      = true
      cognito                             = true
      comprehend                          = true
      config                              = true
      connect                             = true
      data_lifecyle_manager               = true
      data_sync                           = true
      dev_ops_guru                        = true
      database_migration_service          = true
      direct_connect                      = true
      directory_service                   = true
      document_db                         = true
      dynamo_db                           = true
      dynamo_db_accelerator               = true
      ec2                                 = true
      elastic_gpus                        = true
      ec2_spot                            = true
      auto_scaling                        = true
      elastic_beanstalk                   = true
      ebs                                 = true
      ecr                                 = true
      ecs                                 = true
      ecs_container_insights              = true
      ecs_managed_scaling                 = true
      efs                                 = true
      elastic_interface                   = true
      container_insights                  = true
      application_elb                     = true
      network_elb                         = true
      gateway_elb                         = true
      elb                                 = true
      elastic_transcoder                  = true
      elasti_cache                        = true
      es                                  = true
      elastic_map_reduce                  = true
      media_connect                       = true
      media_convert                       = true
      media_live                          = true
      media_package                       = true
      media_store                         = true
      media_tailor                        = true
      sms_voice                           = true
      social_messaging                    = true
      events                              = true
      fsx                                 = true
      game_lift                           = true
      global_accelerator                  = true
      glue                                = true
      ground_station                      = true
      health_lake                         = true
      inspector                           = true
      ivs                                 = true
      ivs_chat                            = true
      iot                                 = true
      iot_analytics                       = true
      iot_fleet_wise                      = true
      iot_site_wise                       = true
      iot_twin_maker                      = true
      kms                                 = true
      cassandra                           = true
      kinesis_analytics                   = true
      firehose                            = true
      kinesis                             = true
      kinesis_video                       = true
      lambda                              = true
      lex                                 = true
      license_manager_license_usage       = true
      license_manager_linux_subscriptions = true
      location                            = true
      lookout_equipment                   = true
      lookout_metrics                     = true
      lookout_vision                      = true
      ml                                  = true
      managed_blockchain                  = true
      prometheus                          = true
      kafka                               = true
      kafka_connect                       = true
      mwaa                                = true
      memory_db                           = true
      amazon_mq                           = true
      neptune                             = true
      network_firewall                    = true
      network_manager                     = true
      nimble_studio                       = true
      omics                               = true
      ops_works                           = true
      outposts                            = true
      panorama_device_metrics             = true
      personalize                         = true
      pinpoint                            = true
      polly                               = true
      private_link_endpoints              = true
      private_link_services               = true
      private_5g                          = true
      qldb                                = true
      quick_sight                         = true
      redshift                            = true
      rds                                 = true
      rekognition                         = true
      re_post_private                     = true
      robomaker                           = true
      route53                             = true
      route53_recovery_readiness          = true
      sage_maker                          = true
      sage_maker_model_building_pipeline  = true
      secrets_manager                     = true
      security_lake                       = true
      service_catalog                     = true
      ddos_protection                     = true
      ses                                 = true
      sim_space_weaver                    = true
      sns                                 = true
      sqs                                 = true
      s3                                  = true
      s3_storage_lens                     = true
      swf                                 = true
      states                              = true
      storage_gateway                     = true
      ssm_run_command                     = true
      textract                            = true
      timestream                          = true
      transfer                            = true
      transcribe                          = true
      translate                           = true
      trusted_advisor                     = true
      nat_gateway                         = true
      transit_gateway                     = true
      vpn                                 = true
      ipam                                = true
      waf                                 = true
      waf_v2                              = true
      work_mail                           = true
      work_spaces                         = true
      work_spaces_web                     = true
    }
    include_custom_namespaces = true
  }

  # enable all resource types
  resource_types = {
    metrics           = true
    logs              = true
    traces            = true
    insights          = true
    internet_monitors = true
  }

  # add some tags
  tags = {
    foo = "bar"
  }
}
