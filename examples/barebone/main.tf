module "github_repository" {
  source = "../.."

  github_owner = "jdevto"

  repository = {
    name = "barebone-repo"
  }
}
