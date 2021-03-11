locals {
  jenkins_folders = [
    { name = "backend", display_name = "Back-end" },
    { name = "web", display_name = "Web" },
    { name = "mobile", display_name = "Mobile" },
  ]

  jenkins_multibranch_pipelines = {}
}
