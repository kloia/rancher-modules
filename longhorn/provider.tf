provider "rancher2" {
  api_url    = "https://rancher.mydomain.com"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  #insecure = true
}
