variable "name" {
  type        = string
  description = "The name of the observability access manager sink, which collects observability data - logs, metrics, traces"
  default     = "monitoring-sink"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be added to the specific resource"
  default     = {}
}
