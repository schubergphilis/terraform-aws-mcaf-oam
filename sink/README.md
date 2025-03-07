# terraform-aws-oam/sink

Terraform module to implement AWS Observability Access Manager Sink.

## Notes

Please be advised the module deploys an OAM Sink with the following:

- Sink Policy will allow links from the entire organization. This is deliberately done to allow you to scale accounts without needing to re-configure the sink with explicit account IDs.
- Sink Policy allows any resource type, it does not specify condition with the `oam:ResourceTypes` condition key. This is to allow you to control egress from the link-side onl.

## Use

### Deployment

#### Examples

Please visit the annotated examples in the `./examples/` folder. They will explain how you can use the different variables to achieve different strategies.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.72 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.72 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_oam_sink.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/oam_sink) | resource |
| [aws_oam_sink_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/oam_sink_policy) | resource |
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the observability access manager sink, which collects observability data - logs, metrics, traces | `string` | `"monitoring-sink"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to the specific resource | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
<!-- END_TF_DOCS -->
