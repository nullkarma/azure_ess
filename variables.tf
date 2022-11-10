variable "es_deployment_template" {
  default = "azure-storage-optimized"
}

variable "es_version" {
  default = 8.4.3
}

variable "es_node_memory_size" {
  default = "8g"
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

variable "ec_deployment" {
  default = {}
}
