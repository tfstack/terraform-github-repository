module "github_repository_template" {
  source = "../.."

  github_owner = "jdevto"

  repository = {
    name        = "template-repo"
    auto_init   = true
    is_template = true
  }
}

module "github_repository_from_template" {
  source = "../.."

  github_owner = "jdevto"

  repository = {
    name = "from-template-repo"

    template = {
      repository           = "template-repo"
      owner                = "jdevto"
      include_all_branches = false
    }
  }
}
