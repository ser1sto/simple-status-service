resource "kubernetes_config_map" "simple_status_service_config" {
  metadata {
    name = "simple-status-service-config"
  }

  data = {
    APP_ENV = "production"
  }
}
