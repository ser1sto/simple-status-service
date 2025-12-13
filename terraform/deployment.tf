resource "kubernetes_deployment" "simple_status_service" {
  metadata {
    name = "simple-status-service"
    labels = {
      app = "simple-status-service"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "simple-status-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "simple-status-service"
        }
      }

      spec {
        security_context {
          run_as_non_root = true
          run_as_user     = 10001
        }
        container {
          name  = "simple-status-service"
          image = "simple-status-service:local"
          image_pull_policy = "Never"
          
          readiness_probe {
            http_get {
              path = "/health"
              port = 8080
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }

          liveness_probe {
            http_get {
              path = "/health"
              port = 8080
            }
            initial_delay_seconds = 10
            period_seconds        = 10
          }

          resources {
            limits = {
              cpu    = "200m"
              memory = "256Mi"
            }
            requests = {
              cpu    = "50m"
              memory = "64Mi"
            }
          }

          port {
            container_port = 8080
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.simple_status_service_config.metadata[0].name
            }
          }
        }
      }
    }
  }
}
