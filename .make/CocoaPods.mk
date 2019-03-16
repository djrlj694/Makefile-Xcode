# CocoaPods.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: CocoaPods
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.1.0
# CREATED: 04FEB2019
# REVISED: 16MAR2019
#
# NOTES:
#   For more info on terminology, style conventions, or source references, see
#   the file ".make/README.md".
# ==============================================================================

# ==============================================================================
# Internal Constants
# ==============================================================================

# ------------------------------------------------------------------------------
# Files
# ------------------------------------------------------------------------------

COCOAPODS_FILES := Framework.podspec

# ==============================================================================
# Phony Targets
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
# ==============================================================================

.INTERMEDIATE: Framework.podspec.download
