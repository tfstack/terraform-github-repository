# terraform-github-repository

Terraform module to manage GitHub Repository

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 6.4.0 |

### Set GitHub token

export GITHUB_TOKEN=ghp_xxx

### Required permission

[] repo
[] admin:org:write:org
[] delete_repo

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | >= 6.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_branch.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch) | resource |
| [github_branch_default.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [github_branch_protection.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) | resource |
| [github_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_branch_protection"></a> [branch\_protection](#input\_branch\_protection) | A list to configure multiple GitHub branch protection settings. | <pre>list(object({<br/>    pattern                         = optional(string, null)<br/>    enforce_admins                  = optional(bool, false)<br/>    require_signed_commits          = optional(bool, false)<br/>    required_linear_history         = optional(bool, false)<br/>    require_conversation_resolution = optional(bool, false)<br/>    required_status_checks = optional(object({<br/>      strict   = optional(bool, false)<br/>      contexts = optional(list(string), [])<br/>    }), null)<br/>    required_pull_request_reviews = optional(object({<br/>      dismiss_stale_reviews           = optional(bool, false)<br/>      restrict_dismissals             = optional(bool, false)<br/>      dismissal_restrictions          = optional(list(string), [])<br/>      pull_request_bypassers          = optional(list(string), [])<br/>      require_code_owner_reviews      = optional(bool, false)<br/>      required_approving_review_count = optional(number, null)<br/>      require_last_push_approval      = optional(bool, false)<br/>    }), null)<br/>    restrict_pushes = optional(object({<br/>      blocks_creations = optional(bool, true)<br/>      push_allowances  = optional(list(string), [])<br/>    }), null)<br/>    force_push_bypassers = optional(list(string), [])<br/>    allows_deletions     = optional(bool, false)<br/>    allows_force_pushes  = optional(bool, false)<br/>    lock_branch          = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| <a name="input_branches"></a> [branches](#input\_branches) | A list of branch configurations to create in the repository. | <pre>list(object({<br/>    branch        = string<br/>    source_branch = optional(string, "main")<br/>    source_sha    = optional(string, null)<br/>  }))</pre> | `[]` | no |
| <a name="input_default_branch"></a> [default\_branch](#input\_default\_branch) | A map containing the branch details and rename flag for the default branch. | <pre>object({<br/>    branch = optional(string, null)<br/>    rename = optional(bool, false)<br/>  })</pre> | `{}` | no |
| <a name="input_github_owner"></a> [github\_owner](#input\_github\_owner) | The GitHub user or organization that owns the repository. | `string` | `null` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | The GitHub repository configuration. | <pre>object({<br/>    name                        = string<br/>    description                 = optional(string, null)<br/>    homepage_url                = optional(string, null)<br/>    private                     = optional(bool)<br/>    visibility                  = optional(string, null)<br/>    has_issues                  = optional(bool)<br/>    has_discussions             = optional(bool)<br/>    has_projects                = optional(bool)<br/>    has_wiki                    = optional(bool)<br/>    is_template                 = optional(bool)<br/>    allow_merge_commit          = optional(bool)<br/>    allow_squash_merge          = optional(bool)<br/>    allow_rebase_merge          = optional(bool)<br/>    allow_auto_merge            = optional(bool)<br/>    squash_merge_commit_title   = optional(string, "COMMIT_OR_PR_TITLE")<br/>    squash_merge_commit_message = optional(string, "COMMIT_MESSAGES")<br/>    merge_commit_title          = optional(string, "MERGE_MESSAGE")<br/>    merge_commit_message        = optional(string, "PR_TITLE")<br/>    delete_branch_on_merge      = optional(bool)<br/>    web_commit_signoff_required = optional(bool)<br/>    has_downloads               = optional(bool)<br/>    auto_init                   = optional(bool)<br/>    gitignore_template          = optional(string, null)<br/>    license_template            = optional(string, null)<br/>    archived                    = optional(bool)<br/>    archive_on_destroy          = optional(bool)<br/><br/>    pages = optional(object({<br/>      source = optional(object({<br/>        branch = string<br/>        path   = optional(string, null)<br/>      }), null)<br/>      build_type = optional(string, "workflow")<br/>      cname      = optional(string, null)<br/>    }), null)<br/><br/>    security_and_analysis = optional(object({<br/>      advanced_security = optional(object({<br/>        status = string<br/>      }), null)<br/>      secret_scanning = optional(object({<br/>        status = string<br/>      }), null)<br/>      secret_scanning_push_protection = optional(object({<br/>        status = string<br/>      }), null)<br/>    }), null)<br/><br/>    topics = optional(list(string), [])<br/><br/>    template = optional(object({<br/>      owner                = string<br/>      repository           = string<br/>      include_all_branches = optional(bool, false)<br/>    }), null)<br/><br/>    vulnerability_alerts                    = optional(bool, true)<br/>    ignore_vulnerability_alerts_during_read = optional(bool)<br/>    allow_update_branch                     = optional(bool)<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_branch_protections"></a> [branch\_protections](#output\_branch\_protections) | Detailed branch protection configuration for each pattern. |
| <a name="output_branches"></a> [branches](#output\_branches) | Details of the branches created in the repository, including branch name and source branch. |
| <a name="output_repository_full_name"></a> [repository\_full\_name](#output\_repository\_full\_name) | A string of the form 'orgname/reponame' for the GitHub repository. |
| <a name="output_repository_git_clone_url"></a> [repository\_git\_clone\_url](#output\_repository\_git\_clone\_url) | URL that can be provided to git clone to clone the repository anonymously via the git protocol. |
| <a name="output_repository_html_url"></a> [repository\_html\_url](#output\_repository\_html\_url) | URL to the repository on the web. |
| <a name="output_repository_http_clone_url"></a> [repository\_http\_clone\_url](#output\_repository\_http\_clone\_url) | URL that can be provided to git clone to clone the repository via HTTPS. |
| <a name="output_repository_node_id"></a> [repository\_node\_id](#output\_repository\_node\_id) | GraphQL global node ID for use with the GitHub v4 API. |
| <a name="output_repository_pages_custom_404"></a> [repository\_pages\_custom\_404](#output\_repository\_pages\_custom\_404) | Indicates whether the rendered GitHub Pages site has a custom 404 page. |
| <a name="output_repository_pages_html_url"></a> [repository\_pages\_html\_url](#output\_repository\_pages\_html\_url) | The absolute URL (including scheme) of the rendered GitHub Pages site. |
| <a name="output_repository_pages_status"></a> [repository\_pages\_status](#output\_repository\_pages\_status) | The GitHub Pages site's build status, e.g., 'building' or 'built'. |
| <a name="output_repository_primary_language"></a> [repository\_primary\_language](#output\_repository\_primary\_language) | The primary language used in the repository. |
| <a name="output_repository_repo_id"></a> [repository\_repo\_id](#output\_repository\_repo\_id) | The GitHub ID for the repository. |
| <a name="output_repository_ssh_clone_url"></a> [repository\_ssh\_clone\_url](#output\_repository\_ssh\_clone\_url) | URL that can be provided to git clone to clone the repository via SSH. |
| <a name="output_repository_svn_url"></a> [repository\_svn\_url](#output\_repository\_svn\_url) | URL that can be provided to svn checkout to check out the repository via GitHub's Subversion protocol emulation. |
