data "ec_deployment" "this" {
  id = var.ec_deployment_id
}

data "template_file" "es_config" {
  template = templatefile(
    "${path.module}/elasticsearch.yaml.tpl", {
      kibana_endpoint         = data.ec_deployment.this.kibana.0.https_endpoint
      federation_metadata_url = var.azure_tenant_id
      azuread_id              = var.azuread_id
      azure_tenant_id         = var.azure_tenant_id
      azuread_application_id  = var.azuread_application_id
  })
}

data "template_file" "kibana_config" {
  template = templatefile(
    "${path.module}/kibana.yaml.tpl", {
  })
}

resource "ec_deployment" "ess" {
  name                   = data.ec_deployment.this.name
  alias                  = data.ec_deployment.this.alias
  deployment_template_id = var.es_deployment_template
  region                 = data.ec_deployment.this.region
  version                = var.es_version
  tags                   = data.ec_deployment.this.tags

  elasticsearch {
    autoscale = var.es_autoscale
    ref_id    = data.ec_deployment.this.elasticsearch.0.ref_id
    config {
      user_settings_yaml = data.template_file.es_config.rendered
    }
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
    ref_id                       = data.ec_deployment.this.kibana.0.ref_id
    elasticsearch_cluster_ref_id = data.ec_deployment.this.elasticsearch.0.ref_id
    config {
      user_settings_yaml = data.template_file.kibana_config.rendered
    }
    topology {
      instance_configuration_id = var.kibana_deployment_template
      size                      = var.kibana_memory_size
      zone_count                = var.kibana_zone_count
    }
  }
}