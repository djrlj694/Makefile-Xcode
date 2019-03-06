# Carthage.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: Carthage.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.1.0
# CREATED: 04FEB2019
# REVISED: 06MAR2019
# ==============================================================================

# ==============================================================================
# Variables
# ==============================================================================

# ------------------------------------------------------------------------------
# Directories
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Files
# ------------------------------------------------------------------------------

CARTHAGE_FILES = Cartfile Cartfile.private

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

.PHONY: clean-carthage

clean-carthage: | $(LOG) ## Completes all Carthage cleanup activities.
	@printf "Removing Carthage setup..."
	@rm -rf $(CARTHAGE_FILES) >$(LOG) 2>&1; \
	$(STATUS_RESULT)

# ------------------------------------------------------------------------------
# Prerequisite phony targets for the "init" target
# ------------------------------------------------------------------------------

.PHONY: init-carthage

## init-carthage: Completes all initial Carthage setup activities.
init-carthage: $(CARTHAGE_FILES)

# ==============================================================================
# File Targets
# ==============================================================================

# Makes a Cartfile file for listing runtime Carthage dependencies.
Cartfile: | $(LOG)
	@printf "Making empty file $(TARGET_VAR)..."
	@touch $@ >$(LOG) 2>&1; \
	$(STATUS_RESULT)

# Makes a Cartfile file for listing private Carthage dependencies.
Cartfile.private: | $(LOG)
	@printf "Making empty file $(TARGET_VAR)..."
	@touch $@ >$(LOG) 2>&1; \
	$(STATUS_RESULT)

## Makes a setup file.
carthage_setup: setup.download 
