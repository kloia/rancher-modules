provider "rancher2" {
  api_url    = "https://myrancher.domain.com"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  insecure   = true
}