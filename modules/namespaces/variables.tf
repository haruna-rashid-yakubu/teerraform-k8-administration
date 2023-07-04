variable "namespaces" {
    type = map(string)
    default = {
      "name" = "haroun",
      "label" = "kubetest"
      "annotation" = "kubernetes_annotation"
    }
}