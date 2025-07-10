provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "node_app" {
  metadata {
    name = "node-app"
    labels = {
      app = "node-app"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "node-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "node-app"
        }
      }

      spec {

        image_pull_secrets {
          name = "acr-secret"
        }

        container {
          name  = "node-app"
          image = "acrdevopsprojectswithterraform.azurecr.io/node-api:1.1"

          port {
            container_port = 3000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "node_service" {
  metadata {
    name = "node-service"
  }

  spec {
    selector = {
      app = "node-app"
    }

    port {
      port        = 80
      target_port = 3000
    }

    type = "NodePort"
  }
}
