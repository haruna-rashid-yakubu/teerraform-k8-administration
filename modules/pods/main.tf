resource "kubernetes_pod" "terraform_pod" {
  metadata {
    namespace = "worketyamo"
    name = "popod"
    labels = {
      app  = "kubetest"
      type = "pod"
    }
    annotations = {
      app = "kubetest"
    }
  }

  spec {
    container {
      name  = "nginx"
      image = "nginx"
      port {
        container_port = 80

      }

    }
    container {
      name    = "ubuntu"
      image   = "ubuntu"
      command = ["sleep", "1000"]
    }
  }

}
