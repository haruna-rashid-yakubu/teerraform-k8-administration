variable "pod_info" {
  type = map(string)
  default = {
    "name" = "terraform_nginx"
    "app_label" = "kubetest"
    "name_annotation" = "kubernetes"
  }
}


variable "container_info" {
    type = map(map(string))
    default = {
      "container1" = {
        "name" = "terraform_nginx"
        "image" = "nginx:1.14.2"
      }
    "container2" = {
        "name" = "terraform_ubuntu"
        "image" = "ubuntu"
      }
    }
}