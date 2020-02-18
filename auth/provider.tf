provider "rancher2" {
  api_url    = "${var.management_server}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  insecure   = true
}