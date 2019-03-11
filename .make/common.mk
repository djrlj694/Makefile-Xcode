# common.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: common.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0.0
# CREATED: 03MAR2019
# REVISED: 11MAR2019
# ==============================================================================

# ==============================================================================
# Internal Constants
#
# An internal constant is a variable that is intended to:
#
# 1. Have a fixed value;
# 2. Be set within a makefile (e.g., "Makefile") or an "include"-ed file).
#
# It is typically defined using the ":=" assignment operator to "simply" expand
# its right-hand side -- i.e., immediately evaluate any variables thererin,
# saving the resulting text as final the value.
#
# By convention, internal constants use uppercase words, separated by dashes.
# ==============================================================================

# ------------------------------------------------------------------------------
# Files
# ------------------------------------------------------------------------------

COMMON_DOCS := README REFERENCES

COMMON_FILES := $(addsuffix .md,$(COMMON_DOCS))
COMMON_DOWNLOADED_FILES := $(addsuffix .download,$(COMMON_FILES))

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
# Prerequisite phony targets for the "clean" target
# ------------------------------------------------------------------------------

.PHONY: clean-common clean-docs-common

## clean-common: Completes all Xcode cleanup activities.
clean-common: clean-docs-common

## clean-docs-common: Completes all common document cleanup activities.
clean-docs-common: | $(LOG)
	@printf "Removing common documents..."
	@rm -rf $(COMMON_FILES) 2>&1; \
	$(status_result)

# ------------------------------------------------------------------------------
# Prerequisite phony targets for the "docs" target
# ------------------------------------------------------------------------------

.PHONY: docs-common 

## docs-common: Completes all common document generation activites.
docs-common: $(COMMON_FILES)

# ------------------------------------------------------------------------------
# Prerequisite phony targets for the "init" target
# ------------------------------------------------------------------------------

.PHONY: init-common

## init-common: Completes all initial common setup activites.
ifeq ($(COOKIECUTTER),)
init-common: docs-common
endif

# ==============================================================================
# File Targets
# ==============================================================================

## README.md: Makes a README.md file.
README.md: README.sed README.md.download
	$(update-file)

# Makes a sed script for file README.sed.
README.sed:
	@echo $(PROJECT_CMD) >> $@
	@echo $(EMAIL_CMD) >> $@
	@echo $(GITHUB_USER_CMD) >> $@
	@echo $(TRAVIS_USER_CMD) >> $@

## REFERENCES.md: Makes a REFERENCES.md file.
REFERENCES.md: REFERENCES.md.download

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

.INTERMEDIATE: $(COMMON_DOWNLOADED_FILES) README.sed
