# common.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: common.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0.0
# CREATED: 03MAR2019
# REVISED: 03MAR2019
# ==============================================================================

# ==============================================================================
# Variables
# ==============================================================================

# ------------------------------------------------------------------------------
# Files
# ------------------------------------------------------------------------------

COMMON_DOCS = README REFERENCES

COMMON_FILES = $(addsuffix .md,$(COMMON_DOCS))
COMMON_DOWNLOADED_FILES = $(addsuffix .download,$(COMMON_FILES))

# ==============================================================================
# Macros
# ==============================================================================

define update-common-file
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

.PHONY: clean-common clean-docs-common

clean-common: clean-docs-common ## Completes all Xocde cleanup activities.

clean-docs-common: | $(LOG) ## Completes all common document cleanup activities.
	@printf "Removing common documents..."
	@rm -rf $(COMMON_FILES) 2>&1; \
	$(RESULT)

# ------------------------------------------------------------------------------
# Prerequisite phony targets for document generation activities
# ------------------------------------------------------------------------------

.PHONY: docs-common 

docs-common: $(COMMON_FILES) ## Completes all common document generation activites.

# ------------------------------------------------------------------------------
# Prerequisite phony targets for initial setup activities
# ------------------------------------------------------------------------------

.PHONY: init-common

init-common: docs-common ## Completes all initial common setup activites.

# ==============================================================================
# File Targets
# ==============================================================================

README.md: README.md.download ## Makes a README.md file.
	$(update-common-file)

REFERENCES.md: REFERENCES.md.download ## Makes a REFERENCES.md file.

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

.INTERMEDIATE: $(COMMON_DOWNLOADED_FILES)
