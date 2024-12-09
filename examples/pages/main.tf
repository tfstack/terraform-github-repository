module "github_repository" {
  source = "../.."

  github_owner = "jdevto"

  repository = {
    name        = "pages-repo"
    auto_init   = true
    is_template = true

    pages = {
      build_type = "workflow"
      source = {
        branch = "main"
        path   = "/docs"
      }
    }
  }
}
