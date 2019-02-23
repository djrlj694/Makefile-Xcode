# GitHub.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: GitHub.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0
# CREATED: 23FEB2019
# REVISED: 23FEB2019
# ==============================================================================

# ==============================================================================
# Variables
# ==============================================================================

# Accounts

GITHUB_USER = $(USER)

# Directories

GITHUB_DIR = .github
ISSUE_TEMPLATE_DIR = $(GITHUB_DIR)/ISSUE_TEMPLATE

# Files

DOCS1 = CHANGELOG ISSUE_TEMPLATE README REFERENCES SUPPORT
DOCS2 = $(addprefix $(GITHUB_DIR)/,CODE_OF_CONDUCT CONTRIBUTING) 
DOCS3 = $(addprefix $(ISSUE_TEMPLATE_DIR)/,bug_report custom feature_request)

MD_FILES = $(addsuffix .md,$(DOCS1) $(DOCS2) $(DOCS3))

# URLs

GITHUB = https://raw.githubusercontent.com/$(GITHUB_USER)/makefile-xcode/master/templates
ORIGIN = https://github.com/$(GITHUB_USER)/$(PROJECT).git

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

# Prerequisite phony targets for cleaning activities

.PHONY: clean-md

clean-md: | $(LOG) ## Completes all Markdown cleanup activities.
	@printf "Removing Markdown setup..."
	@rm -rf $(MD_FILES) >$(LOG) 2>&1; \
	$(RESULT)

# Prerequisite phony targets for initial setup activities

.PHONY: init-md 

init-md: $(MD_FILES) ## Completes all initial Markdown file setup activites.

# ==============================================================================
# File Targets
# ==============================================================================

$(GITHUB_DIR)/CODE_OF_CONDUCT.md: CODE_OF_CONDUCT.md.download ## Makes a CODE_OF_CONDUCT.md file.

$(GITHUB_DIR)/CONTRIBUTING.md: CONTRIBUTING.md.download ## Makes a CONTRIBUTING.md file.

$(ISSUE_TEMPLATE_DIR)/bug_report.md: bug_report.md.download ## Makes a bug_report.md file.

$(ISSUE_TEMPLATE_DIR)/custom.md: custom.md.download ## Makes a custom.md file.

$(ISSUE_TEMPLATE_DIR)/feature_request.md: feature_request.md.download ## Makes a feature_request.md file.

CHANGELOG.md: CHANGELOG.md.download ## Makes a CHANGELOG.md file.

ISSUE_TEMPLATE.md: ISSUE_TEMPLATE.md.download ## Makes a ISSUE_TEMPLATE.md file.

README.md: ISSUE_TEMPLATE.md.download ## Makes a README.md file.

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

.INTERMEDIATE: bug_report.md.download

.INTERMEDIATE: CHANGELOG.md.download

.INTERMEDIATE: CODE_OF_CONDUCT.md.download

.INTERMEDIATE: CONTRIBUTING.md.download

.INTERMEDIATE: custom.md.download

.INTERMEDIATE: feature_request.md.download

.INTERMEDIATE: ISSUE_TEMPLATE.md.download

.INTERMEDIATE: README.md.download

.INTERMEDIATE: REFERENCES.md.download

.INTERMEDIATE: SUPPORT.md.download
