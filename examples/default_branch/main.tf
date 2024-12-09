module "github_repository_default_rename_existing" {
  source = "../.."

  github_owner = "jdevto"

  repository = {
    name        = "default-branch-default-rename-repo"
    auto_init   = true
    is_template = true
  }

  default_branch = {
    branch = "prod"
    rename = true
  }
}

module "github_repository_default_change" {
  source = "../.."

  github_owner = "jdevto"

  repository = {
    name        = "default-branch-default-change-repo"
    auto_init   = true
    is_template = true
  }

  branches = [
    {
      branch        = "prod"
      source_branch = "main"
    },
  ]

  default_branch = {
    branch = "prod"
  }
}
