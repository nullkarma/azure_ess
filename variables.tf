variable "es_deployment_template" {
  default = "azure-storage-optimized"
}

variable "ec_deployment_id" {}

variable "es_autoscale" {
  default = "false"
}

variable "es_topology" {
  default = [
    {
      id          = "hot_content"
      size        = "8g"
      node_data   = "false"
      node_ingest = "false"
      node_master = "false"
      node_ml     = "false"
      zone_count  = 2
  }]
}

variable "es_version" {
  default = "8.4.3"
}

variable "kibana_deployment_template" {
  default = "azure.kibana.fsv2"
}

variable "kibana_memory_size" {
  default = "1g"
}

variable "kibana_zone_count" {
  default = 1
}

variable "azure_tenant_id" {}
variable "azuread_id" {}
variable "azuread_application_id" {}
