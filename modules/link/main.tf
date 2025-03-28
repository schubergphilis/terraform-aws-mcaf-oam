resource "aws_oam_link" "default" {
  label_template  = var.label_template
  resource_types  = local.enabled_resource_types
  sink_identifier = var.sink_arn
  tags            = var.tags

  dynamic "link_configuration" {
    for_each = local.link_configuration_enabled ? [true] : []

    content {
      dynamic "log_group_configuration" {
        for_each = local.link_configuration_log_enabled ? [true] : []

        content {
          filter = local.log_group_query
        }
      }

      dynamic "metric_configuration" {
        for_each = local.link_configuration_metrics_enabled ? [true] : []

        content {
          filter = local.metric_query
        }
      }
    }
  }
}
