# Carthage.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: Carthage.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.1.0
# CREATED: 04FEB2019
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
# Files
# ------------------------------------------------------------------------------

CARTHAGE_FILES := Cartfile Cartfile.private

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

.PHONY: clean-carthage

clean-carthage: | $(LOG) ## Completes all Carthage cleanup activities.
	@printf "Removing Carthage setup..."
	@rm -rf $(CARTHAGE_FILES) >$(LOG) 2>&1; \
	$(status_result)

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
	@printf "Making empty file $(target_var)..."
	@touch $@ >$(LOG) 2>&1; \
	$(status_result)

# Makes a Cartfile file for listing private Carthage dependencies.
Cartfile.private: | $(LOG)
	@printf "Making empty file $(target_var)..."
	@touch $@ >$(LOG) 2>&1; \
	$(status_result)

## Makes a setup file.
carthage_setup: setup.download 
