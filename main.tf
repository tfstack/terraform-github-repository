
# REPOSITORY
resource "github_repository" "this" {
  name                        = var.repository.name
  description                 = var.repository.description
  homepage_url                = var.repository.homepage_url
  private                     = var.repository.visibility != null ? null : var.repository.private
  visibility                  = var.repository.visibility
  has_issues                  = var.repository.has_issues
  has_discussions             = var.repository.has_discussions
  has_projects                = var.repository.has_projects
  has_wiki                    = var.repository.has_wiki
  is_template                 = var.repository.is_template
  allow_merge_commit          = var.repository.allow_merge_commit
  allow_squash_merge          = var.repository.allow_squash_merge
  allow_rebase_merge          = var.repository.allow_rebase_merge
  allow_auto_merge            = var.repository.allow_auto_merge
  squash_merge_commit_title   = var.repository.squash_merge_commit_title
  squash_merge_commit_message = var.repository.squash_merge_commit_message
  merge_commit_title          = var.repository.merge_commit_title
  merge_commit_message        = var.repository.merge_commit_message
  delete_branch_on_merge      = var.repository.delete_branch_on_merge
  web_commit_signoff_required = var.repository.web_commit_signoff_required
  has_downloads               = var.repository.has_downloads
  auto_init                   = var.repository.auto_init
  gitignore_template          = var.repository.gitignore_template
  license_template            = var.repository.license_template
  archived                    = var.repository.archived
  archive_on_destroy          = var.repository.archive_on_destroy

  dynamic "pages" {
    for_each = var.repository.pages != null ? [1] : []
    content {
      build_type = var.repository.pages.build_type != null ? var.repository.pages.build_type : null
      cname      = var.repository.pages.cname != null ? var.repository.pages.cname : null

      dynamic "source" {
        for_each = var.repository.pages.source != null ? [1] : []
        content {
          branch = var.repository.pages.source.branch
          path   = var.repository.pages.source.path
        }
      }
    }
  }

  dynamic "security_and_analysis" {
    for_each = var.repository.security_and_analysis != null ? [1] : []
    content {
      dynamic "advanced_security" {
        for_each = var.repository.security_and_analysis.advanced_security != null ? [1] : []
        content {
          status = var.repository.security_and_analysis.advanced_security.status
        }
      }

      dynamic "secret_scanning" {
        for_each = var.repository.security_and_analysis.secret_scanning != null ? [1] : []
        content {
          status = var.repository.security_and_analysis.secret_scanning.status
        }
      }

      dynamic "secret_scanning_push_protection" {
        for_each = var.repository.security_and_analysis.secret_scanning_push_protection != null ? [1] : []
        content {
          status = var.repository.security_and_analysis.secret_scanning_push_protection.status
        }
      }
    }
  }

  topics = var.repository.topics

  dynamic "template" {
    for_each = (
      var.repository.template != null &&
      try(var.repository.template.owner != "", true) &&
      try(var.repository.template.repository != "", true) ?
      [1] : []
    )
    content {
      owner      = var.repository.template.owner
      repository = var.repository.template.repository
      include_all_branches = (
        var.repository.template.include_all_branches != null ?
        var.repository.template.include_all_branches :
        false
      )
    }
  }

  vulnerability_alerts                    = var.repository.vulnerability_alerts
  ignore_vulnerability_alerts_during_read = var.repository.ignore_vulnerability_alerts_during_read
  allow_update_branch                     = var.repository.allow_update_branch
}

# BRANCHES
resource "github_branch" "this" {
  for_each = { for idx, branch in var.branches : idx => branch }

  repository    = github_repository.this.name
  branch        = each.value.branch
  source_branch = each.value.source_branch
  source_sha    = each.value.source_sha != "" ? each.value.source_sha : null
}

# DEFAULT BRANCH
resource "github_branch_default" "this" {
  count = (
    var.default_branch != null &&
    var.default_branch.branch != null
  ) ? 1 : 0

  repository = github_repository.this.name
  branch     = var.default_branch.branch
  rename     = var.default_branch.rename

  depends_on = [
    github_branch.this
  ]
}

resource "github_branch_protection" "this" {
  for_each = tomap({
    for i, protection in var.branch_protection :
    i => protection
    if protection != null &&
    protection.pattern != null &&
    protection.pattern != ""
  })

  repository_id                   = var.repository.name
  pattern                         = each.value.pattern
  enforce_admins                  = each.value.enforce_admins
  require_signed_commits          = each.value.require_signed_commits
  required_linear_history         = each.value.required_linear_history
  require_conversation_resolution = each.value.require_conversation_resolution

  dynamic "required_status_checks" {
    for_each = each.value.required_status_checks != null ? [each.value.required_status_checks] : []
    content {
      strict   = required_status_checks.value.strict
      contexts = required_status_checks.value.contexts
    }
  }

  dynamic "required_pull_request_reviews" {
    for_each = each.value.required_pull_request_reviews != null ? [each.value.required_pull_request_reviews] : []
    content {
      dismiss_stale_reviews           = required_pull_request_reviews.value.dismiss_stale_reviews
      restrict_dismissals             = required_pull_request_reviews.value.restrict_dismissals
      dismissal_restrictions          = required_pull_request_reviews.value.dismissal_restrictions
      pull_request_bypassers          = required_pull_request_reviews.value.pull_request_bypassers
      require_code_owner_reviews      = required_pull_request_reviews.value.require_code_owner_reviews
      required_approving_review_count = required_pull_request_reviews.value.required_approving_review_count
      require_last_push_approval      = required_pull_request_reviews.value.require_last_push_approval
    }
  }

  dynamic "restrict_pushes" {
    for_each = each.value.restrict_pushes != null ? [each.value.restrict_pushes] : []
    content {
      blocks_creations = restrict_pushes.value.blocks_creations
      push_allowances  = restrict_pushes.value.push_allowances
    }
  }

  force_push_bypassers = each.value.force_push_bypassers
  allows_deletions     = each.value.allows_deletions
  allows_force_pushes  = each.value.allows_force_pushes
  lock_branch          = each.value.lock_branch

  depends_on = [
    github_branch.this
  ]
}
