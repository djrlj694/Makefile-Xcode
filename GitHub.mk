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
TRAVIS_USER = $(USER)

EMAIL = $(USER)@gmail.com

# Directories

GITHUB_DIR1 = .github
GITHUB_DIR2 = $(GITHUB_DIR1)/ISSUE_TEMPLATE

# Files

DOCS1 = CHANGELOG ISSUE_TEMPLATE README REFERENCES SUPPORT
DOCS2 = $(addprefix $(GITHUB_DIR1)/,CODE_OF_CONDUCT CONTRIBUTING) 
DOCS3 = $(addprefix $(GITHUB_DIR2)/,bug_report custom feature_request)

GITHUB_FILES = $(addsuffix .md,$(DOCS1) $(DOCS2) $(DOCS3))

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

.PHONY: clean-docs-github

clean-docs-github: | $(LOG) ## Completes all GitHub Markdown cleanup activities.
	@printf "Removing Markdown setup..."
	@rm -rf $(GITHUB_FILES) $(GITHUB_DIR1) >$(LOG) 2>&1; \
	$(RESULT)

# Prerequisite phony targets for initial setup activities

.PHONY: init-github 

init-github: docs-github ## Completes all initial Github setup activites.

# Prerequisite phony targets for initial setup activities

.PHONY: docs-github 

docs-github: $(GITHUB_FILES) ## Completes all GitHub document activites.

# ==============================================================================
# File Targets
# ==============================================================================

$(GITHUB_DIR1)/CODE_OF_CONDUCT.md: CODE_OF_CONDUCT.md.download | $$(@D)/. ## Makes a CODE_OF_CONDUCT.md file.
	@printf "Moving file $(FILE_VAR) to directory $(DIR_VAR)..."
	@mv $(shell basename $(@F)) $(@D); \
	$(RESULT)
	@sed -e 's/<PROJECT>/$(PROJECT)/g' $@ >$@.tmp1
	@sed -e 's/<GITHUB_USER>/$(GITHUB_USER)/g' $@.tmp1 >$@.tmp2
	@sed -e 's/<EMAIL>/$(EMAIL)/g' $@.tmp2 >$@
	@rm -rf $@.tmp*

$(GITHUB_DIR1)/CONTRIBUTING.md: CONTRIBUTING.md.download | $$(@D)/. ## Makes a CONTRIBUTING.md file.
	@printf "Moving file $(FILE_VAR) to directory $(DIR_VAR)..."
	@mv $(shell basename $(@F)) $(@D); \
	$(RESULT)
	@sed -e 's/<PROJECT>/$(PROJECT)/g' $@ >$@.tmp1
	@sed -e 's/<GITHUB_USER>/$(GITHUB_USER)/g' $@.tmp1 >$@.tmp2
	@sed -e 's/<EMAIL>/$(EMAIL)/g' $@.tmp2 >$@
	@rm -rf $@.tmp*

$(GITHUB_DIR2)/bug_report.md: bug_report.md.download | $$(@D)/.## Makes a bug_report.md file.
	@printf "Moving file $(FILE_VAR) to directory $(DIR_VAR)..."
	@mv $(shell basename $(@F)) $(@D); \
	$(RESULT)

$(GITHUB_DIR2)/custom.md: custom.md.download | $$(@D)/. ## Makes a custom.md file.
	@printf "Moving file $(FILE_VAR) to directory $(DIR_VAR)..."
	@mv $(shell basename $(@F)) $(@D); \
	$(RESULT)

$(GITHUB_DIR2)/feature_request.md: feature_request.md.download | $$(@D)/. ## Makes a feature_request.md file.
	@printf "Moving file $(FILE_VAR) to directory $(DIR_VAR)..."
	@mv $(shell basename $(@F)) $(@D); \
	$(RESULT)

CHANGELOG.md: CHANGELOG.md.download ## Makes a CHANGELOG.md file.

ISSUE_TEMPLATE.md: ISSUE_TEMPLATE.md.download ## Makes a ISSUE_TEMPLATE.md file.

README.md: README.md.download ## Makes a README.md file.
	@sed -e 's/{{PROJECT}}/$(PROJECT)/g' $@ >$@.tmp1
	@sed -e 's/<GITHUB_USER>/$(GITHUB_USER)/g' $@.tmp1 >$@.tmp2
	@sed -e 's/<TRAVIS_USER>/$(TRAVIS_USER)/g' $@.tmp2 >$@
	@rm -rf $@.tmp*

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
