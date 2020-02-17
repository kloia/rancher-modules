resource "rancher2_namespace" "qa_namespace" {
  name = "selenium_staging"
  project_id = "cluster_id:project_id"
  description = "Staging Environment Namespace"
  resource_quota {
    limit {
      limits_cpu = "100m"
      limits_memory = "100Mi"
      requests_storage = "1Gi"
    }
  }
  container_resource_limit {
    limits_cpu = "20m"
    limits_memory = "20Mi"
    requests_cpu = "1m"
    requests_memory = "1Mi"
  }
}