# GitHub.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: GitHub.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0
# CREATED: 23FEB2019
# REVISED: 12MAR2019
# ==============================================================================

# ==============================================================================
# Internal Constants
#
# An internal constant is a variable that is intended to:
#
# 1. Have a fixed value;
# 2. Be set within a makefile (e.g., "Makefile") or an "include"-ed file.
#
# It is typically defined using the ":=" assignment operator to "simply" expand
# its right-hand side -- i.e., immediately evaluate any variables thererin,
# saving the resulting text as final the value.
#
# By convention, its name uses uppercase, dash-separated words.
# ==============================================================================

# ------------------------------------------------------------------------------
# Accounts
# ------------------------------------------------------------------------------

GITHUB_USER := $(USER)
TRAVIS_USER := $(USER)

EMAIL := $(USER)@gmail.com

# ------------------------------------------------------------------------------
# Directories
# ------------------------------------------------------------------------------

GITHUB_DIR1 := .github
GITHUB_DIR2 := $(GITHUB_DIR1)/ISSUE_TEMPLATE
GITHUB_DIR3 := $(GITHUB_DIR1)/PULL_REQUEST_TEMPLATE

GITHUB_DIRS := $(addsuffix /.,$(GITHUB_DIR2) $(GITHUB_DIR3))

# ------------------------------------------------------------------------------
# Files
# ------------------------------------------------------------------------------

GITHUB_DOCS0 := CHANGELOG CODE_OF_CONDUCT CONTRIBUTING SUPPORT
#GITHUB_DOCS1 := $(addprefix $(GITHUB_DIR1)/,CODE_OF_CONDUCT CONTRIBUTING) 
GITHUB_DOCS2 := $(addprefix $(GITHUB_DIR2)/,bug_report custom feature_request ISSUE_TEMPLATE)
GITHUB_DOCS3 := $(addprefix $(GITHUB_DIR3)/,pull_request_template)
GITHUB_DOCS := $(GITHUB_DOCS0) $(GITHUB_DOCS2) $(GITHUB_DOCS3)

GITHUB_FILES := $(addsuffix .md,$(GITHUB_DOCS))
GITHUB_DOWNLOADED_FILES := $(addsuffix .download,$(GITHUB_FILES))

# ==============================================================================
# Phony Targets
#
# A phony target is one that does not represent a file or directory. It can be
# thought of as an embedded shell script. It runs when an explicit request is
# made unless a file of the same name exists.
#
# Two reasons to use a phony target are:
#
# 1. To avoid a conflict with a file of the same name;
# 2. To improve performance.
# ==============================================================================

# ------------------------------------------------------------------------------
# Prerequisite phony targets for the "clean" target
# ------------------------------------------------------------------------------

.PHONY: clean-docs-github

## clean-github: Completes all GitHub cleanup activities.
clean-github: clean-docs-github

## clean-docs-github: Completes all GitHub Markdown cleanup activities.
clean-docs-github: | $(LOG)
	@printf "Removing GitHub documents..."
	@rm -rf $(GITHUB_FILES) $(GITHUB_DIR1) >$(LOG) 2>&1; \
	$(status_result)

# ------------------------------------------------------------------------------
# Prerequisite phony targets for the "docs" target
# ------------------------------------------------------------------------------

.PHONY: docs-github 

## docs-github: Completes all GitHub document generation activites.
docs-github: $(GITHUB_FILES)

# ------------------------------------------------------------------------------
# Prerequisite phony targets for the "init" target
# ------------------------------------------------------------------------------

.PHONY: init-github init-github-dirs init-github-vars

## init-github: Completes all initial Github setup activites.
ifeq ($(COOKIECUTTER),)
init-github: init-github-vars init-github-dirs docs-github
else
init-github: init-github-vars
	@cookiecutter gh:$(TEMPLATES_REPO)
endif

## init-github-dirs: Completes all initial Github directorry setup activites.
init-github-dirs: $(GITHUB_DIRS)

## init-github-vars: Completes all GitHub variable setup activites.
init-github-vars:
	$(eval PROJECT_REPO = $(GITHUB_USER)/$(PROJECT))
	$(eval TEMPLATES_REPO = $(GITHUB_USER)/Cookiecutter-GitHub)
	$(eval FILE_URL = https://raw.githubusercontent.com/$(TEMPLATES_REPO)/master/%7B%7Bcookiecutter.project_name%7D%7D)
	$(eval ORIGIN_URL = https://github.com/$(PROJECT_REPO).git)

# ==============================================================================
# File Targets
# ==============================================================================

# Makes a bug_report.md file.
$(GITHUB_DIR2)/bug_report.md: $(GITHUB_DIR2)/bug_report.md.download

# Makes a custom.md file.
$(GITHUB_DIR2)/custom.md: $(GITHUB_DIR2)/custom.md.download

# Makes a feature_request.md file.
$(GITHUB_DIR2)/feature_request.md: $(GITHUB_DIR2)/feature_request.md.download

# Makes a ISSUE_TEMPLATE.md file.
$(GITHUB_DIR2)/ISSUE_TEMPLATE.md: $(GITHUB_DIR2)/ISSUE_TEMPLATE.md.download

# Makes a pull_request_template.md file.
$(GITHUB_DIR3)/pull_request_template.md: $(GITHUB_DIR3)/pull_request_template.md.download

# Makes a CHANGELOG.md file.
CHANGELOG.md: CHANGELOG.md.download

# Makes a CODE_OF_CONDUCT.md file.
CODE_OF_CONDUCT.md: CODE_OF_CONDUCT.sed CODE_OF_CONDUCT.md.download
	$(update-file)

# Makes a sed script for file CODE_OF_CONDUCT.sed.
CODE_OF_CONDUCT.sed:
	@echo $(PROJECT_CMD) >> $@
	@echo $(EMAIL_CMD) >> $@
	@echo $(GITHUB_USER_CMD) >> $@

# Makes a CONTRIBUTING.md file.
CONTRIBUTING.md: CONTRIBUTING.sed CONTRIBUTING.md.download
	$(update-file)

# Makes a sed script for file CONTRIBUTING.sed.
CONTRIBUTING.sed:
	@echo $(PROJECT_CMD) >> $@
	@echo $(EMAIL_CMD) >> $@
	@echo $(GITHUB_USER_CMD) >> $@

# Makes a SUPPORT.md file.
SUPPORT.md: SUPPORT.md.download

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

.INTERMEDIATE: $(GITHUB_DOWNLOADED_FILES) CODE_OF_CONDUCT.sed CONTRIBUTING.sed
