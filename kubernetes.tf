resource "kubernetes_deployment" "java" {
  metadata {
    name = "microservice-deployment"
    labels = {
      app  = "java-microservice"
    }
  }
spec {
    replicas = 2
selector {
      match_labels = {
        app  = "java-microservice"
      }
    }
template {
      metadata {
        labels = {
          app  = "java-microservice"
        }
      }
spec {
        container {
          image = "304370290957.dkr.ecr.us-west-2.amazonaws.com/javappbrillius:latest"
          name  = "java-microservice-container"
          port {
            container_port = 8080
         }
        }
      }
    }
  }
}
resource "kubernetes_service" "java" {
  depends_on = [kubernetes_deployment.java]
  metadata {
    name = "java-microservice-service"
  }
  spec {
    selector = {
      app = "java-microservice"
    }
    port {
      port        = 80
      target_port = 8080
    }
type = "LoadBalancer"
}
}
