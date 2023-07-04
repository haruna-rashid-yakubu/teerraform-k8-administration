output "scheduler" {
  value = kubernetes_pod.terraform_pod.metadata[0].name
}
