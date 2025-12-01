resource "kubernetes_service" "simple_status_service" {
  metadata {
    name = "simple-status-service"
  }

  spec {
    selector = {
      app = "simple-status-service"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "ClusterIP"
  }
}
