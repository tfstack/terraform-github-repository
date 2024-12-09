run "setup" {
  module {
    source = "./tests/setup"
  }
}

# Run setup to create a GitHub repository
run "setup_github_repository_barebone" {
  variables {
    github_owner = "jdevto"
    repository = {
      name        = "barebone-repo-${run.setup.suffix}"
      description = "Barebone repository setup for testing" # Add description here
      visibility  = "private"                               # Set visibility instead of private
    }
  }

  # Assert that the repository name matches the expected repository name
  assert {
    condition     = github_repository.this.name == "barebone-repo-${run.setup.suffix}"
    error_message = "GitHub repository name does not match 'barebone-repo-${run.setup.suffix}'"
  }
}
