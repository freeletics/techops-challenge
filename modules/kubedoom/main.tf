resource "kubernetes_namespace" "kubedoom" {
  metadata {
    name = "kubedoom"
  }
}

resource "kubernetes_deployment" "kubedoom" {

  depends_on = [
    kubernetes_namespace.kubedoom,
    kubernetes_service_account.kubedoom,
    kubernetes_cluster_role_binding.kubedoom
  ]

  metadata {
    name      = "kubedoom"
    namespace = "kubedoom"
    labels = {
      app = "kubedoom"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "kubedoom"
      }
    }

    template {
      metadata {
        labels = {
          app = "kubedoom"
        }
      }

      spec {
        enable_service_links = true
        service_account_name = "kubedoom"
        container {
          image = "storaxdev/kubedoom:0.5.0"
          name  = "kubedoom"

          port {
            container_port = 5900
            name           = "vnc"
          }
        }
        container {
          image = "jhankins/docker-novnc:latest"
          name  = "novnc"
          port {
            container_port = 6080
            name           = "novnc"
          }
          args = ["--vnc", "127.0.0.1:5900"]
        }
      }
    }
  }
}




resource "kubernetes_service_account" "kubedoom" {
  depends_on = [
    kubernetes_namespace.kubedoom
  ]

  metadata {
    name      = "kubedoom"
    namespace = "kubedoom"
  }
}

resource "kubernetes_cluster_role_binding" "kubedoom" {
  depends_on = [
    kubernetes_service_account.kubedoom
  ]

  metadata {
    name = "kubedoom"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "kubedoom"
    namespace = "kubedoom"
  }
}
