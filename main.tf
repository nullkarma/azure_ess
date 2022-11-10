data "ec_deployment" "this" {
  id = "562141dd3cdf42f7a5f3250144b2e052"
}

output "foobar" {
  value = data.ec_deployment.this
}

resource "ec_deployment" "this" {
  name                   = data.ec_deployment.this.name
  alias                  = data.ec_deployment.this.alias
  deployment_template_id = var.es_deployment_template
  region                 = data.ec_deployment.this.region
  version                = var.es_version
  tags                   = data.ec_deployment.this.tags

  elasticsearch {
    autoscale = "false"
    ref_id    = data.ec_deployment.this.elasticsearch.0.ref_id
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
    ref_id                       = data.ec_deployment.this.kibana.0.ref_id
    elasticsearch_cluster_ref_id = data.ec_deployment.this.elasticsearch.0.ref_id
    topology {
      instance_configuration_id = var.kibana_deployment_template
      size                      = var.kibana_memory_size
      zone_count                = var.kibana_zone_count
    }
  }
}