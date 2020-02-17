resource "rancher2_app" "foo" {
  catalog_name = "library"
  name = "longhorn"
  description = "Longhorn App"
  project_id = "${var.project_name}"
  template_name = "longhorn"
  template_version = "0.7.0"
  target_namespace = "longhorn-system"
  depends_on = ["rancher2_namespace.foo"]
}

resource "rancher2_namespace" "foo" {
  name = "longhorn-system"
  project_id = "${var.project_name}"
  description = "Longhorn Namespace"
}