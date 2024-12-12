module "github_repository" {
  source = "../.."

  github_owner = "jdevto"

  repository = {
    name        = "default-branch-protection-repo"
    auto_init   = true
    is_template = true
  }

  branch_protection = [
    {
      pattern                         = "main"
      enforce_admins                  = true
      require_signed_commits          = true
      required_linear_history         = true
      require_conversation_resolution = true

      required_status_checks = {
        strict = true
        contexts = [
          "ci/circleci",
          "ci/github-actions"
        ]
      }

      required_pull_request_reviews = {
        dismiss_stale_reviews           = true
        restrict_dismissals             = true
        dismissal_restrictions          = ["/jajera"]
        pull_request_bypassers          = []
        require_code_owner_reviews      = true
        required_approving_review_count = 1
        require_last_push_approval      = true
      }

      restrict_pushes = {
        blocks_creations = true
        push_allowances  = ["/jajera"]
      }

      force_push_bypassers = []
      allows_deletions     = false
      allows_force_pushes  = false
      lock_branch          = true
    },
    {
      pattern                         = "production"
      enforce_admins                  = true
      require_signed_commits          = true
      required_linear_history         = true
      require_conversation_resolution = true

      required_status_checks = {
        strict = true
        contexts = [
          "ci/build",
          "ci/test",
          "ci/deploy"
        ]
      }

      required_pull_request_reviews = {
        dismiss_stale_reviews           = true
        restrict_dismissals             = true
        dismissal_restrictions          = ["/jajera"]
        pull_request_bypassers          = []
        require_code_owner_reviews      = true
        required_approving_review_count = 2
        require_last_push_approval      = true
      }

      restrict_pushes = {
        blocks_creations = true
        push_allowances  = ["/jajera"]
      }

      force_push_bypassers = ["/jajera"]
      allows_deletions     = false
      allows_force_pushes  = false
      lock_branch          = true
    },

    {
      pattern                         = "staging"
      enforce_admins                  = true
      require_signed_commits          = true
      required_linear_history         = true
      require_conversation_resolution = true

      required_status_checks = {
        strict = true
        contexts = [
          "ci/build",
          "ci/test",
          "ci/lint"
        ]
      }

      required_pull_request_reviews = {
        dismiss_stale_reviews           = true
        restrict_dismissals             = true
        dismissal_restrictions          = ["/jajera"]
        pull_request_bypassers          = ["/jajera"]
        require_code_owner_reviews      = true
        required_approving_review_count = 2
        require_last_push_approval      = true
      }

      restrict_pushes = {
        blocks_creations = true
        push_allowances  = ["/jajera"]
      }

      force_push_bypassers = ["/jajera"]

      allows_deletions    = true
      allows_force_pushes = false
      lock_branch         = true
    },

    {
      pattern                         = "hotfix/*"
      enforce_admins                  = true
      require_signed_commits          = true
      required_linear_history         = true
      require_conversation_resolution = true

      required_status_checks = {
        strict = false
        contexts = [
          "ci/hotfix-check"
        ]
      }

      required_pull_request_reviews = {
        dismiss_stale_reviews           = true
        restrict_dismissals             = true
        dismissal_restrictions          = ["/jajera"]
        pull_request_bypassers          = []
        require_code_owner_reviews      = true
        required_approving_review_count = 1
        require_last_push_approval      = false
      }

      restrict_pushes = {
        blocks_creations = true
        push_allowances  = ["/jajera"]
      }

      force_push_bypassers = ["/jajera"]

      allows_deletions    = true
      allows_force_pushes = false
      lock_branch         = true
    },

    {
      pattern                         = "release/*"
      enforce_admins                  = true
      require_signed_commits          = true
      required_linear_history         = true
      require_conversation_resolution = true

      required_status_checks = {
        strict = true
        contexts = [
          "ci/release-check",
          "ci/release-build"
        ]
      }

      required_pull_request_reviews = {
        dismiss_stale_reviews           = true
        restrict_dismissals             = true
        dismissal_restrictions          = ["/jajera"]
        pull_request_bypassers          = []
        require_code_owner_reviews      = true
        required_approving_review_count = 2
        require_last_push_approval      = true
      }

      restrict_pushes = {
        blocks_creations = true
        push_allowances  = ["/jajera"]
      }

      force_push_bypassers = ["/jajera"]

      allows_deletions    = false
      allows_force_pushes = false
      lock_branch         = true
    },

    {
      pattern                         = "feature/*"
      enforce_admins                  = true
      require_signed_commits          = true
      required_linear_history         = true
      require_conversation_resolution = true

      required_status_checks = {
        strict = true
        contexts = [
          "ci/circleci",
          "ci/github-actions"
        ]
      }

      required_pull_request_reviews = {
        dismiss_stale_reviews           = true
        restrict_dismissals             = true
        dismissal_restrictions          = []
        pull_request_bypassers          = []
        require_code_owner_reviews      = true
        required_approving_review_count = 1
        require_last_push_approval      = true
      }

      restrict_pushes = {
        blocks_creations = true
        push_allowances  = []
      }

      force_push_bypassers = []

      allows_deletions    = false
      allows_force_pushes = false
      lock_branch         = false
    },
    {
      pattern                         = "experimental/*"
      enforce_admins                  = true
      require_signed_commits          = true
      required_linear_history         = true
      require_conversation_resolution = true

      required_status_checks = {
        strict = true
        contexts = [
          "ci/circleci",
          "ci/github-actions"
        ]
      }

      required_pull_request_reviews = {
        dismiss_stale_reviews           = true
        restrict_dismissals             = true
        dismissal_restrictions          = []
        pull_request_bypassers          = []
        require_code_owner_reviews      = false
        required_approving_review_count = 1
        require_last_push_approval      = true
      }

      restrict_pushes = {
        blocks_creations = true
        push_allowances  = []
      }

      force_push_bypassers = []

      allows_deletions    = true
      allows_force_pushes = false
      lock_branch         = false
    }
  ]
}
