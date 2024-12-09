output "repository_full_name" {
  description = "A string of the form 'orgname/reponame' for the GitHub repository."
  value       = github_repository.this.full_name
}

output "repository_html_url" {
  description = "URL to the repository on the web."
  value       = github_repository.this.html_url
}

output "repository_ssh_clone_url" {
  description = "URL that can be provided to git clone to clone the repository via SSH."
  value       = github_repository.this.ssh_clone_url
}

output "repository_http_clone_url" {
  description = "URL that can be provided to git clone to clone the repository via HTTPS."
  value       = github_repository.this.http_clone_url
}

output "repository_git_clone_url" {
  description = "URL that can be provided to git clone to clone the repository anonymously via the git protocol."
  value       = github_repository.this.git_clone_url
}

output "repository_svn_url" {
  description = "URL that can be provided to svn checkout to check out the repository via GitHub's Subversion protocol emulation."
  value       = github_repository.this.svn_url
}

output "repository_node_id" {
  description = "GraphQL global node ID for use with the GitHub v4 API."
  value       = github_repository.this.node_id
}

output "repository_repo_id" {
  description = "The GitHub ID for the repository."
  value       = github_repository.this.id
}

output "repository_primary_language" {
  description = "The primary language used in the repository."
  value       = github_repository.this.primary_language
}

output "repository_pages_custom_404" {
  description = "Indicates whether the rendered GitHub Pages site has a custom 404 page."
  value       = try(github_repository.this.pages[0].custom_404, null)
}

output "repository_pages_html_url" {
  description = "The absolute URL (including scheme) of the rendered GitHub Pages site."
  value       = try(github_repository.this.pages[0].html_url, null)
}

output "repository_pages_status" {
  description = "The GitHub Pages site's build status, e.g., 'building' or 'built'."
  value       = try(github_repository.this.pages[0].status, null)
}

output "branches" {
  description = "Details of the branches created in the repository, including branch name and source branch."
  value = [
    for branch in github_branch.this : {
      branch_name   = branch.branch
      source_branch = branch.source_branch
      source_sha    = branch.source_sha
    }
  ]
}

output "branch_protections" {
  description = "Detailed branch protection configuration for each pattern."
  value = [
    for protection in github_branch_protection.this : {
      pattern                         = protection.pattern
      enforce_admins                  = protection.enforce_admins
      require_signed_commits          = protection.require_signed_commits
      required_linear_history         = protection.required_linear_history
      require_conversation_resolution = protection.require_conversation_resolution
      required_status_checks          = protection.required_status_checks != null ? protection.required_status_checks : []
      required_pull_request_reviews   = protection.required_pull_request_reviews != null ? protection.required_pull_request_reviews : []
      restrict_pushes                 = protection.restrict_pushes != null ? protection.restrict_pushes : []
      force_push_bypassers            = protection.force_push_bypassers
      allows_deletions                = protection.allows_deletions
      allows_force_pushes             = protection.allows_force_pushes
      lock_branch                     = protection.lock_branch
    }
  ]
}
