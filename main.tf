resource "ec_deployment" "ess" {
  name                   = var.ec_deployment.name
  alias                  = var.ec_deployment.alias
  deployment_template_id = var.es_deployment_template
  region                 = var.ec_deployment.region
  version                = var.es_version
  tags                   = var.ec_deployment.tags

  elasticsearch {
    autoscale = "false"
    ref_id    = var.ec_deployment.elasticsearch.0.ref_id
    topology {
      id               = "hot_content"
      size             = var.es_node_memory_size
      zone_count       = 2
      node_type_data   = "false"
      node_type_ingest = "false"
      node_type_master = "false"
      node_type_ml     = "false"
    }
  }
  kibana {
    ref_id                       = var.ec_deployment.kibana.0.ref_id
    elasticsearch_cluster_ref_id = var.ec_deployment.elasticsearch.0.ref_id
    topology {
      instance_configuration_id = var.kibana_deployment_template
      size                      = var.kibana_memory_size
      zone_count                = var.kibana_zone_count
    }
  }
}