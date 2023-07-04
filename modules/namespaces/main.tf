  resource "kubernetes_namespace" "terraform" {
  metadata {
    annotations = {
      name = var.namespaces.annotation
    }
    labels = {
      app = var.namespaces.label
    }
    name = var.namespaces.name
  }
}