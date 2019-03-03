# GitHub.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: GitHub.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0
# CREATED: 23FEB2019
# REVISED: 03MAR2019
# ==============================================================================

# ==============================================================================
# Variables
# ==============================================================================

# ------------------------------------------------------------------------------
# Accounts
# ------------------------------------------------------------------------------

GITHUB_USER = $(USER)
TRAVIS_USER = $(USER)

EMAIL = $(USER)@gmail.com

# ------------------------------------------------------------------------------
# Directories
# ------------------------------------------------------------------------------

GITHUB_DIR1 = .github
GITHUB_DIR2 = $(GITHUB_DIR1)/ISSUE_TEMPLATE
GITHUB_DIR3 = $(GITHUB_DIR1)/PULL_REQUEST_TEMPLATE

GITHUB_DIRS = $(addsuffix /.,$(GITHUB_DIR2) $(GITHUB_DIR3))

# ------------------------------------------------------------------------------
# Files
# ------------------------------------------------------------------------------

#DOCS0 = CHANGELOG README REFERENCES SUPPORT
DOCS0 = CHANGELOG CODE_OF_CONDUCT CONTRIBUTING README REFERENCES SUPPORT
#DOCS1 = $(addprefix $(GITHUB_DIR1)/,CODE_OF_CONDUCT CONTRIBUTING) 
DOCS2 = $(addprefix $(GITHUB_DIR2)/,bug_report custom feature_request ISSUE_TEMPLATE)
DOCS3 = $(addprefix $(GITHUB_DIR3)/,pull_request_template)

GITHUB_FILES = $(addsuffix .md,$(DOCS0) $(DOCS1) $(DOCS2) $(DOCS3))
GITHUB_DOWNLOADED_FILES = $(addsuffix .download,$(GITHUB_FILES))

# ==============================================================================
# Macros
# ==============================================================================

define update-github-file
	@sed -e 's/{{ cookiecutter.project_name }}/$(PROJECT)/g' $@ >$@.tmp1
	@sed -e 's/{{ cookiecutter.github_user }}/$(GITHUB_USER)/g' $@.tmp1 >$@.tmp2
	@sed -e 's/{{ cookiecutter.email }}/$(EMAIL)/g' $@.tmp2 >$@.tmp3
	@sed -e 's/{{ cookiecutter.github_user }}/$(GITHUB_USER)/g' $@.tmp3 >$@.tmp4
	@sed -e 's/{{ cookiecutter.travis_user }}/$(TRAVIS_USER)/g' $@.tmp4 >$@
	@rm -rf $@.tmp*
endef

# ==============================================================================
# Phony Targets
#
# A phony target is a convenient name for a set of commands to be executed when
# an explicit request is made.  Its commands won't run if a file of the same
# name exists.  Two reasons to use a phony target are:
#
# 1. To avoid a conflict with a file of the same name;
# 2. To improve performance.
# ==============================================================================

# ------------------------------------------------------------------------------
# Prerequisite phony targets for cleaning activities
# ------------------------------------------------------------------------------

.PHONY: clean-docs-github

clean-docs-github: | $(LOG) ## Completes all GitHub Markdown cleanup activities.
	@printf "Removing Markdown setup..."
	@rm -rf $(GITHUB_FILES) $(GITHUB_DIR1) >$(LOG) 2>&1; \
	$(RESULT)

# ------------------------------------------------------------------------------
# Prerequisite phony targets for initial setup activities
# ------------------------------------------------------------------------------

.PHONY: init-github init-github-dirs init-github-vars

init-github: init-github-dirs init-github-vars docs-github ## Completes all initial Github setup activites.

init-github-dirs: $(GITHUB_DIRS)

init-github-vars: ## Completes all GitHub variable setup activites.
	$(eval PROJECT_REPO = $(GITHUB_USER)/$(PROJECT))
	$(eval TEMPLATES_REPO = $(GITHUB_USER)/Cookiecutter-GitHub)
	$(eval FILE_URL = https://raw.githubusercontent.com/$(TEMPLATES_REPO)/master/%7B%7Bcookiecutter.project_name%7D%7D)
	$(eval ORIGIN_URL = https://github.com/$(PROJECT_REPO).git)

# ------------------------------------------------------------------------------
# Prerequisite phony targets for document generation activities
# ------------------------------------------------------------------------------

.PHONY: docs-github 

docs-github: $(GITHUB_FILES) ## Completes all GitHub document generation activites.

# ==============================================================================
# File Targets
# ==============================================================================

CODE_OF_CONDUCT.md: CODE_OF_CONDUCT.md.download ## Makes a CODE_OF_CONDUCT.md file.
	$(update-github-file)

CONTRIBUTING.md: CONTRIBUTING.md.download ## Makes a CONTRIBUTING.md file.
	$(update-github-file)

$(GITHUB_DIR2)/bug_report.md: $(GITHUB_DIR2)/bug_report.md.download ## Makes a bug_report.md file.

$(GITHUB_DIR2)/custom.md: $(GITHUB_DIR2)/custom.md.download ## Makes a custom.md file.

$(GITHUB_DIR2)/feature_request.md: $(GITHUB_DIR2)/feature_request.md.download ## Makes a feature_request.md file.

$(GITHUB_DIR2)/ISSUE_TEMPLATE.md: $(GITHUB_DIR2)/ISSUE_TEMPLATE.md.download ## Makes a ISSUE_TEMPLATE.md file.

$(GITHUB_DIR3)/pull_request_template.md: $(GITHUB_DIR3)/pull_request_template.md.download ## Makes a pull_request_template.md file.

CHANGELOG.md: CHANGELOG.md.download ## Makes a CHANGELOG.md file.

README.md: README.md.download ## Makes a README.md file.
	$(update-github-file)

REFERENCES.md: REFERENCES.md.download ## Makes a REFERRENCES.md file.

SUPPORT.md: SUPPORT.md.download ## Makes a SUPPORT.md file.

# ==============================================================================
# Intermediate Targets
#
# An intermediate target corresponds to a file that is needed on the way from a
# source file to a target file.  It typically is a temporary file that is needed
# only once to generate the target after the source changed.  The "make" command
# automatically removes files that are identified as intermediate targets.  In
# other words, such files that did not exist before a "make" run executed do not
# exist after a "make" run.
# ==============================================================================

.INTERMEDIATE: $(GITHUB_DOWNLOADED_FILES)
