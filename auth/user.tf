resource "rancher2_project_role_template_binding" "qa_user_template_binding" {
  name = "foo"
  project_id = "c-p888r:p-rdtsr"
  role_template_id = "${rancher2_role_template.qa_role_template.id}"
  user_id = "${rancher2_user.qa_user.id}"
}

resource "rancher2_role_template" "qa_role_template" {
  name = "foo"
  context = "project"
  default_role = false
  description = "Terraform role template acceptance test"
  rules {
    api_groups = ["*"]
    resources = ["secrets"]
    verbs = ["get", "list"]
  }
}

resource "rancher2_user" "qa_user" {
  name = "Foo user"
  username = "qa_user"
  password = "qa123"
  enabled = true
}