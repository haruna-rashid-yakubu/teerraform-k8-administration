terraform {
  backend "kubernetes" {
    secret_suffix = "harouna"
    config_path   = "~/.kube/config"
    namespace     = "worketyamo"
  }
}

data "terraform_remote_state" "foo" {
  backend = "kubernetes"
  config = {
    secret_suffix = "harouna"
    config_path   = "~/.kube/config"
    namespace     = "worketyamo"
  }
}


provider "kubernetes" {
  config_path = "~/.kube/config"
}


locals {
  name = "harouna"
  type = "webapp"
}

resource "kubernetes_deployment" "my_deployment" {
  metadata {
    name      = "${local.name}-my-deployment"
    namespace = "worketyamo"
    labels = {
      owner = local.name
      type  = local.type
    }
  }
  spec {

    template {
      metadata {
        name = "${local.name}-pod"
        labels = {
          owner = "${local.name}-pod"
          app   = local.type
        }
      }

      spec {
        container {
          name  = "mon-ct"
          image = "marwaney/work-et-yamo"

          port {
            container_port = 80
          }
        }
        image_pull_secrets {
          name = "regcred"
        }
      }
    }
    strategy {
      type = "Recreate"
    }
    replicas = 3
    selector {
      match_labels = {
        owner = "${local.name}-pod"
        app   = local.type
      }
    }
  }
}

resource "kubernetes_service" "service" {
  metadata {
    name      = "harouna-service"
    namespace = "worketyamo"
    labels = {
      owner = "harouna"
      type  = "web-app"
    }
  }
  spec {
    selector = {
      owner = "harouna"
      type  = "ssh"
    }
    port {
      port        = 80
      target_port = 80
      node_port   = 30220
    }
    type = "NodePort"
  }
}
