data "template_file" "es_config" {
  template = templatefile("elasticsearch.yaml.tpl", {
    kibana_url = ""
    federation_metadata_url = var.azuread_federation_metadata_url
    azuread_id = var.azuread_id
  })
}

/*
data "template_file" "kibana_config" {
  template = templatefile("kibana.yaml.tpl", {
  })
}
*/

resource "ec_deployment" "ess" {
  name                   = var.ec_deployment.name
  alias                  = var.ec_deployment.alias
  deployment_template_id = var.es_deployment_template
  region                 = var.ec_deployment.region
  version                = var.es_version
  tags                   = var.ec_deployment.tags

  elasticsearch {
    autoscale = var.es_autoscale
    ref_id    = var.ec_deployment.elasticsearch.0.ref_id
    /*
    config {
      user_settings_yaml =
    }
    */
    dynamic "topology" {
      for_each = var.es_topology

      content {
        id               = topology.value.id
        size             = topology.value.size
        zone_count       = topology.value.zone_count
        node_type_data   = topology.value.node_data
        node_type_ingest = topology.value.node_ingest
        node_type_master = topology.value.node_master
        node_type_ml     = topology.value.node_ml
      }
    }
  }
  kibana {
    ref_id                       = var.ec_deployment.kibana.0.ref_id
    elasticsearch_cluster_ref_id = var.ec_deployment.elasticsearch.0.ref_id
    /*
    config {
      user_settings_yaml = ""
    }
    */
    topology {
      instance_configuration_id = var.kibana_deployment_template
      size                      = var.kibana_memory_size
      zone_count                = var.kibana_zone_count
    }
  }
}