resource "rancher2_project_logging" "elastic_search" {
  name = "${var.name}"
  project_id = "${var.project_id}"
  kind = "${var.logging_component}"
  elasticsearch_config {
    endpoint = "${var.elasticsearch_url}"
    ssl_verify = "${var.ssl_verify}"
    index_prefix  = "${var.index_prefix}"
  }
}
