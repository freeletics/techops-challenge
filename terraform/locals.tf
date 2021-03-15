locals {
  environment_file              = jsondecode(file("./environment.json"))
  jenkins_folders               = lookup(local.environment_file.jenkins, "folders", [])
  jenkins_multibranch_pipelines = {}
  credentials                   = jsondecode(data.sops_file.secrets.raw).jenkins.credentials
  personal_kubeconfig           = yamldecode(file(pathexpand("~/.kube/config")))
  index_minikube                = index(local.personal_kubeconfig.contexts[*].name, "minikube")
  host                          = local.personal_kubeconfig.clusters[local.index_minikube].cluster.server
  cluster_ca_certificate        = base64decode(local.personal_kubeconfig.clusters[local.index_minikube].cluster.certificate-authority-data)
  client_certificate            = base64decode(local.personal_kubeconfig.users[local.index_minikube].user.client-certificate-data)
  client_key                    = base64decode(local.personal_kubeconfig.users[local.index_minikube].user.client-key-data)
}

output "kubeconfig" {
  value = local.index_minikube
}
