module "github_repository" {
  source = "../.."

  github_owner = "jdevto"

  repository = {
    name      = "security-analysis-repo"
    auto_init = true

    security_and_analysis = {
      advanced_security = {
        status = "enabled"
      }
      secret_scanning = {
        status = "enabled"
      }
      secret_scanning_push_protection = {
        status = "enabled"
      }
    }

    visibility = "private"
  }
}
