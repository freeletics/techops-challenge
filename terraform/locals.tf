locals {
  jenkins_folders = [
    { name = "backend", display_name = "Back-end" },
    { name = "web", display_name = "Web" },
    { name = "tools", display_name = "Tools" },
    { name = "mobile", display_name = "Mobile" },
  ]

  jenkins_multibranch_pipelines = {
    hubot = {
      repository_name       = "fl-chatbot"
      repository_owner      = "freeletics"
      folder_name           = "tools"
      pipeline_display_name = "Ops / Hubot"

      git_credential_id = "github_user_credentials"
    }
  }
}
