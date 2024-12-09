variable "github_owner" {
  description = "The GitHub user or organization that owns the repository."
  type        = string
  default     = null
}

variable "repository" {
  description = "The GitHub repository configuration."
  type = object({
    name                        = string
    description                 = optional(string, null)
    homepage_url                = optional(string, null)
    private                     = optional(bool)
    visibility                  = optional(string, null)
    has_issues                  = optional(bool)
    has_discussions             = optional(bool)
    has_projects                = optional(bool)
    has_wiki                    = optional(bool)
    is_template                 = optional(bool)
    allow_merge_commit          = optional(bool)
    allow_squash_merge          = optional(bool)
    allow_rebase_merge          = optional(bool)
    allow_auto_merge            = optional(bool)
    squash_merge_commit_title   = optional(string, "COMMIT_OR_PR_TITLE")
    squash_merge_commit_message = optional(string, "COMMIT_MESSAGES")
    merge_commit_title          = optional(string, "MERGE_MESSAGE")
    merge_commit_message        = optional(string, "PR_TITLE")
    delete_branch_on_merge      = optional(bool)
    web_commit_signoff_required = optional(bool)
    has_downloads               = optional(bool)
    auto_init                   = optional(bool)
    gitignore_template          = optional(string, null)
    license_template            = optional(string, null)
    archived                    = optional(bool)
    archive_on_destroy          = optional(bool)

    pages = optional(object({
      source = optional(object({
        branch = string
        path   = optional(string, null)
      }), null)
      build_type = optional(string, "workflow")
      cname      = optional(string, null)
    }), null)

    security_and_analysis = optional(object({
      advanced_security = optional(object({
        status = string
      }), null)
      secret_scanning = optional(object({
        status = string
      }), null)
      secret_scanning_push_protection = optional(object({
        status = string
      }), null)
    }), null)

    topics = optional(list(string), [])

    template = optional(object({
      owner                = string
      repository           = string
      include_all_branches = optional(bool, false)
    }), null)

    vulnerability_alerts                    = optional(bool, true)
    ignore_vulnerability_alerts_during_read = optional(bool)
    allow_update_branch                     = optional(bool)
  })

  validation {
    condition     = length(var.repository.name) > 0
    error_message = "The repository name must be a non-empty string."
  }

  validation {
    condition = var.repository.visibility == null || contains([
      "public", "private", "internal"
    ], var.repository.visibility != null ? var.repository.visibility : "")

    error_message = <<EOT
      Invalid value for visibility. Supported values are:
      - public
      - private
      - internal
      EOT
  }

  validation {
    condition     = var.repository.squash_merge_commit_title == "PR_TITLE" || var.repository.squash_merge_commit_title == "COMMIT_OR_PR_TITLE"
    error_message = "squash_merge_commit_title must be either 'PR_TITLE' or 'COMMIT_OR_PR_TITLE'."
  }

  validation {
    condition     = var.repository.squash_merge_commit_message == "PR_BODY" || var.repository.squash_merge_commit_message == "COMMIT_MESSAGES" || var.repository.squash_merge_commit_message == "BLANK"
    error_message = "squash_merge_commit_message must be either 'PR_BODY', 'COMMIT_MESSAGES', or 'BLANK'."
  }

  validation {
    condition     = var.repository.merge_commit_title == "PR_TITLE" || var.repository.merge_commit_title == "MERGE_MESSAGE"
    error_message = "merge_commit_title must be either 'PR_TITLE' or 'MERGE_MESSAGE'."
  }

  validation {
    condition     = var.repository.merge_commit_message == "PR_BODY" || var.repository.merge_commit_message == "PR_TITLE" || var.repository.merge_commit_message == "BLANK"
    error_message = "merge_commit_message must be either 'PR_BODY', 'PR_TITLE', or 'BLANK'."
  }

  validation {
    condition = var.repository.gitignore_template == null || contains([
      "AL", "Actionscript", "Ada", "Agda", "Android", "AppEngine", "AppceleratorTitanium", "ArchLinuxPackages", "Autotools",
      "Ballerina", "C", "C++", "CFWheels", "CMake", "CUDA", "CakePHP", "ChefCookbook", "Clojure", "CodeIgniter", "CommonLisp",
      "Composer", "Concrete5", "Coq", "CraftCMS", "D", "DM", "Dart", "Delphi", "Drupal", "ECU-TEST", "EPiServer", "Eagle",
      "Elisp", "Elixir", "Elm", "Erlang", "ExpressionEngine", "ExtJs", "Fancy", "Finale", "FlaxEngine", "ForceDotCom", "Fortran",
      "FuelPHP", "GWT", "Gcov", "GitBook", "GitHubPages", "Go", "Godot", "Gradle", "Grails", "Haskell", "IAR", "IGORPro", "Idris",
      "JBoss", "JENKINS_HOME", "Java", "Jekyll", "Joomla", "Julia", "KiCad", "Kohana", "Kotlin", "LabVIEW", "Laravel", "Leiningen",
      "LemonStand", "Lilypond", "Lithium", "Lua", "Magento", "Maven", "Mercury", "MetaProgrammingSystem", "Nanoc", "Nim", "Node",
      "OCaml", "Objective-C", "Opa", "OpenCart", "OracleForms", "Packer", "Perl", "Phalcon", "PlayFramework", "Plone", "Prestashop",
      "Processing", "PureScript", "Python", "Qooxdoo", "Qt", "R", "ROS", "Racket", "Rails", "Raku", "ReScript", "RhodesRhomobile",
      "Ruby", "Rust", "SCons", "Sass", "Scala", "Scheme", "Scrivener", "Sdcc", "SeamGen", "SketchUp", "Smalltalk", "Stella", "SugarCRM",
      "Swift", "Symfony", "SymphonyCMS", "TeX", "Terraform", "Textpattern", "TurboGears2", "TwinCAT3", "Typo3", "Unity", "UnrealEngine",
      "VVVV", "VisualStudio", "Waf", "WordPress", "Xojo", "Yeoman", "Yii", "ZendFramework", "Zephir", "Zig"
    ], var.repository.gitignore_template != null ? var.repository.gitignore_template : "")

    error_message = <<EOT
    Invalid value for gitignore_template. Supported values are:
    - AL, Actionscript, Ada, Agda, Android, AppEngine, AppceleratorTitanium, ArchLinuxPackages, Autotools
    - Ballerina, C, C++, CFWheels, CMake, CUDA, CakePHP, ChefCookbook, Clojure, CodeIgniter, CommonLisp
    - Composer, Concrete5, Coq, CraftCMS, D, DM, Dart, Delphi, Drupal, ECU-TEST, EPiServer, Eagle, Elisp
    - Elixir, Elm, Erlang, ExpressionEngine, ExtJs, Fancy, Finale, FlaxEngine, ForceDotCom, Fortran, FuelPHP
    - GWT, Gcov, GitBook, GitHubPages, Go, Godot, Gradle, Grails, Haskell, IAR, IGORPro, Idris, JBoss, JENKINS_HOME
    - Java, Jekyll, Joomla, Julia, KiCad, Kohana, Kotlin, LabVIEW, Laravel, Leiningen, LemonStand, Lilypond
    - Lithium, Lua, Magento, Maven, Mercury, MetaProgrammingSystem, Nanoc, Nim, Node, OCaml, Objective-C, Opa
    - OpenCart, OracleForms, Packer, Perl, Phalcon, PlayFramework, Plone, Prestashop, Processing, PureScript, Python
    - Qooxdoo, Qt, R, ROS, Racket, Rails, Raku, ReScript, RhodesRhomobile, Ruby, Rust, SCons, Sass, Scala, Scheme
    - Scrivener, Sdcc, SeamGen, SketchUp, Smalltalk, Stella, SugarCRM, Swift, Symfony, SymphonyCMS, TeX, Terraform
    - Textpattern, TurboGears2, TwinCAT3, Typo3, Unity, UnrealEngine, VVVV, VisualStudio, Waf, WordPress, Xojo
    - Yeoman, Yii, ZendFramework, Zephir, Zig
    EOT
  }

  validation {
    condition = var.repository.license_template == null || contains([
      "AFL-3.0", "Apache-2.0", "Artistic-2.0", "BSL-1.0", "BSD-2-Clause", "BSD-3-Clause", "BSD-3-Clause-Clear",
      "BSD-4-Clause", "0BSD", "CC", "CC0-1.0", "CC-BY-4.0", "CC-BY-SA-4.0", "WTFPL", "ECL-2.0", "EPL-1.0",
      "EPL-2.0", "EUPL-1.1", "AGPL-3.0", "GPL", "GPL-2.0", "GPL-3.0", "LGPL", "LGPL-2.1", "LGPL-3.0",
      "ISC", "LPPL-1.3c", "MS-PL", "MIT", "MPL-2.0", "OSL-3.0", "PostgreSQL", "OFL-1.1", "NCSA", "Unlicense", "Zlib"
    ], var.repository.license_template != null ? var.repository.license_template : "")

    error_message = <<EOT
    Invalid value for license_template. Supported values are:
    - AFL-3.0, Apache-2.0, Artistic-2.0, BSL-1.0, BSD-2-Clause, BSD-3-Clause, BSD-3-Clause-Clear, BSD-4-Clause, 0BSD
    - CC, CC0-1.0, CC-BY-4.0, CC-BY-SA-4.0, WTFPL, ECL-2.0, EPL-1.0, EPL-2.0, EUPL-1.1, AGPL-3.0, GPL, GPL-2.0, GPL-3.0
    - LGPL, LGPL-2.1, LGPL-3.0, ISC, LPPL-1.3c, MS-PL, MIT, MPL-2.0, OSL-3.0, PostgreSQL, OFL-1.1, NCSA, Unlicense, Zlib
    EOT
  }
}

variable "branches" {
  description = "A list of branch configurations to create in the repository."
  type = list(object({
    branch        = string
    source_branch = optional(string, "main")
    source_sha    = optional(string, null)
  }))
  default = []

  validation {
    condition     = alltrue([for branch in var.branches : length(branch.branch) > 0])
    error_message = "Each branch name must be a non-empty string."
  }

  validation {
    condition     = alltrue([for branch in var.branches : branch.source_branch == "" || length(branch.source_branch) > 0])
    error_message = "Source branch, if provided, must be a non-empty string."
  }

  validation {
    condition     = alltrue([for branch in var.branches : can(length(branch.source_sha)) ? length(branch.source_sha) == 40 : true])
    error_message = "Source SHA, if provided, must be a 40-character commit hash."
  }
}

variable "default_branch" {
  description = "A map containing the branch details and rename flag for the default branch."
  type = object({
    branch = optional(string, null)
    rename = optional(bool, false)
  })
  default = {}
}

variable "branch_protection" {
  description = "A list to configure multiple GitHub branch protection settings."

  type = list(object({
    pattern                         = optional(string, null)
    enforce_admins                  = optional(bool, false)
    require_signed_commits          = optional(bool, false)
    required_linear_history         = optional(bool, false)
    require_conversation_resolution = optional(bool, false)
    required_status_checks = optional(object({
      strict   = optional(bool, false)
      contexts = optional(list(string), [])
    }), null)
    required_pull_request_reviews = optional(object({
      dismiss_stale_reviews           = optional(bool, false)
      restrict_dismissals             = optional(bool, false)
      dismissal_restrictions          = optional(list(string), [])
      pull_request_bypassers          = optional(list(string), [])
      require_code_owner_reviews      = optional(bool, false)
      required_approving_review_count = optional(number, null)
      require_last_push_approval      = optional(bool, false)
    }), null)
    restrict_pushes = optional(object({
      blocks_creations = optional(bool, true)
      push_allowances  = optional(list(string), [])
    }), null)
    force_push_bypassers = optional(list(string), [])
    allows_deletions     = optional(bool, false)
    allows_force_pushes  = optional(bool, false)
    lock_branch          = optional(bool, false)
  }))

  default = []

  validation {
    condition = alltrue([
      for protection in var.branch_protection : (
        protection.force_push_bypassers == [] || !protection.allows_force_pushes
      )
    ])
    error_message = "If force_push_bypassers is not empty, allows_force_pushes must be false."
  }

  validation {
    condition = alltrue([
      for protection in var.branch_protection : protection.pattern != null
    ])
    error_message = "Pattern is required when branch protection is enabled."
  }

  validation {
    condition = alltrue([
      for protection in var.branch_protection : (
        protection.required_pull_request_reviews == null ||
        protection.required_pull_request_reviews.required_approving_review_count == null ||
        (protection.required_pull_request_reviews.required_approving_review_count >= 0 &&
        protection.required_pull_request_reviews.required_approving_review_count <= 6)
      )
    ])
    error_message = "The required_approving_review_count must be between 0 and 6 (inclusive) when specified."
  }
}
