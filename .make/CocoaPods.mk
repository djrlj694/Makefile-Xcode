# CocoaPods.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: CocoaPods
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.1.0
# CREATED: 04FEB2019
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

COCOAPODS_FILES := Framework.podspec

# ==============================================================================
# Phony Targets
#
# A phony target is one that does not represent a file or directory. It can be
# thought of as an embedded shell script to be run when an explicit request
# is made unless uness a file of the same name exists.
#
# Two reasons to use a phony target are:
#
# 1. To avoid a conflict with a file of the same name;
# 2. To improve performance.
# ==============================================================================

# ------------------------------------------------------------------------------
# Prerequisite phony targets for the "clean" target
# ------------------------------------------------------------------------------

.PHONY: clean-cocoapods

## Completes all CocoaPods cleanup activities.
clean-cocoapods: | $(LOG)
	@printf "Removing CocoaPods setup..."
	@rm -rf $(COCOAPODS_FILES) >$(LOG) 2>&1; \
	$(status_result)

# ------------------------------------------------------------------------------
# Prerequisite phony targets for the "init" target
# ------------------------------------------------------------------------------

.PHONY: init-cocoapods 

## init-cocoapods: Completes all initial CocoaPods setup activities.
init-cocoapods: $(COCOAPODS_FILES)

# ==============================================================================
# File Targets
# ==============================================================================

# Makes a Framework.podspec file.
Framework.podspec: Framework.podspec.download

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

.INTERMEDIATE: Framework.podspec.download
