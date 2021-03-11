resource "null_resource" "minikube_healthcheck" {
  provisioner "local-exec" {
    command = <<EOF
    until nc -z 192.168.50.4 443; do
    # until nc -z $(minikube ip) 8443; do
      echo 'Trying again in 10 sec'
      sleep 10
    done
    EOF

    interpreter = ["bash", "-c"]
  }
}

resource "helm_release" "jenkins" {
  name             = "jenkins"
  namespace        = "jenkins"
  create_namespace = true

  repository = "https://charts.jenkins.io/"
  chart      = "jenkins"
  version    = "3.2.1"

  values = [
    yamlencode({
      persistence = {
        enabled = true
      }

      # Jenkins "master" was renamed to controller
      controller = {
        tag = "2.283"

        JCasC = {
          enabled       = true
          defaultConfig = true

          # authorizationStrategy = yamlencode({})
          securityRealm = yamlencode({
            local = {
              allowsSignup = false
              users        = jsondecode(data.sops_file.secrets.raw).jenkins.users
            }
          })

          configScripts = {
            libraries = yamlencode({
              unclassified = {
                globalLibraries = {}
              }
            })

            # Iterate and render the multibranch pipelines defined at locals.tf
            pipelines = yamlencode({
              jobs = [
                for job_def in local.jenkins_multibranch_pipelines : {
                  script = templatefile(
                    "./templates/multibranch.groovy.tpl",
                    merge(job_def, { enabled = true })
                  )
                }
              ]
            })

            # Jenkins folders for a better organization in Jenkins Web UI
            folders = yamlencode({
              jobs = [
                for folder in local.jenkins_folders : {
                  script = templatefile("./templates/folder.groovy.tpl", folder)
                }
              ]
            })

            others = yamlencode({
              unclassified = {
                # Build Timestmap used for Git tags & production releases
                buildTimestamp = {
                  enableBuildTimestamp = true

                  # Ref: https://github.com/freeletics/fl-helm-jenkins/blob/master/values.yaml#L184
                  pattern  = "yyyy-MM-dd_HH-mm"
                  timezone = "Etc/UTC"
                }
              }
            })
          }
        }

        installPlugins = [
          "basic-branch-build-strategies:1.3.2",
          "build-timestamp:1.0.3",
          "command-launcher:1.5",
          "configuration-as-code:1.47",
          "credentials-binding:1.24",
          "git:4.6.0",
          "jdk-tool:1.5",
          "job-dsl:1.77",
          "kubernetes-cli:1.10.0",
          "kubernetes:1.29.2",
          "pipeline-utility-steps:2.6.1",
          "plugin-util-api:2.0.0",
          "role-strategy:3.1", # Role-based Access Strategy (RBAC)
          "startup-trigger-plugin:2.9.3",
          "workflow-aggregator:2.6",
          "workflow-cps:2.90",
          "workflow-job:2.40",
        ]

        resources = {
          limits = {
            cpu    = "1000m",
            memory = "2048Mi"
          },
          requests = {
            cpu    = "250m",
            memory = "1024Mi"
          }
        }
      }

      overwritePlugins = true
    })
  ]

  depends_on = [null_resource.minikube_healthcheck]
}
