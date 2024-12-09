module "github_repository" {
  source = "../.."

  github_owner = "jdevto"

  repository = {
    name        = "branches-repo"
    auto_init   = true
    is_template = true
  }

  branches = [
    {
      branch        = "staging"
      source_branch = "main"
    },
    {
      branch        = "dev"
      source_branch = "main"
    },
  ]
}
