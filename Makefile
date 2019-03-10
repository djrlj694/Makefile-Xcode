# Makefile
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: Makefile
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.1.0
# CREATED: 04FEB2019
# REVISED: 10MAR2019
# ==============================================================================

# .ONESHELL:
# .EXPORT_ALL_VARIABLES:

# ==============================================================================
# External Constants
#
# An external constant represents a variable that is intended to:
#
# 1. Have a fixed value;
# 2. Be set at the command line or by the environment.
#
# It is typically defined using the "?=" assignment operator to "conditionally"
# assign its right-hand side -- i.e., to assign only if a value for the
# variable has not been externally set.
#
# By convention, external constants use uppercase words, separated by dashes.
# ==============================================================================

# ------------------------------------------------------------------------------
# Accounts
# ------------------------------------------------------------------------------

USER ?= $(shell whoami)

# ------------------------------------------------------------------------------
# Directories
# ------------------------------------------------------------------------------

PREFIX = $(PWD)
PROJECT ?= $(shell basename $(PREFIX))
PACKAGE ?= $(PROJECT)

# ==============================================================================
# Internal Constants
#
# An internal constant represents a variable that is intended to:
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
# Debugging & Error Capture
# ------------------------------------------------------------------------------

VARIABLES_TO_SHOW := MAKEFILE MAKEFILE_DIR MAKEFILE_LIST
VARIABLES_TO_SHOW += PACKAGE PREFIX PROJECT PWD USER

# ------------------------------------------------------------------------------
# Directories
# ------------------------------------------------------------------------------

MAKEFILE_DIR = $(dir $(realpath $(MAKEFILE)))/.make

BIN_DIR = bin/.
LOG_DIR = logs/.
SETUP_DIRS = $(BIN_DIR) $(LOG_DIR)

# ------------------------------------------------------------------------------
# Files
# ------------------------------------------------------------------------------

MAKEFILE = $(firstword $(MAKEFILE_LIST))

# Used to create special empty ("marker") files in order to:
# 1. Automaticcally create directory trees if they don't already exist;
# 2. Avoid directory tree rebuilds as their directory timestamps changed.
###DUMMY_FILES = $(addsuffix /.dummy,$(DIRS)) # RLJ: Commented out. 23FEB2019

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
# Main phony targets
# ------------------------------------------------------------------------------

.PHONY: all build clean debug docs init test

all: help

ifneq ($(PROJECT),Makefile-Xcode)
## clean: Completes all cleaning activities.
clean: clean-git clean-xcode clean-github clean-common clean-dirs
endif

## debug: Completes all debugging activities.
debug: debug-vars-some debug-dirs-tree

## docs: Makes API documentation.
docs: docs-swift

## init: Completes all initial repo setup activities.
init: init-dirs init-github init-xcode init-common init-git

## test: Completes all test activities.
test: test-xcode

# ------------------------------------------------------------------------------
# Prerequisite phony targets for the "clean" target
# ------------------------------------------------------------------------------

.PHONY: clean-dirs

## clean-dirs: Completes all directory cleanup activities.
clean-dirs: | $(LOG)
	@printf "Removing directories setup..."
	@rm -rf $(PROJECT) $(dir $(SETUP_DIRS)) >$(LOG) 2>&1; \
	$(status_result)

# ------------------------------------------------------------------------------
# Prerequisite phony targets for the "init" target
# ------------------------------------------------------------------------------

.PHONY: init-dirs

## init-dirs: Completes all initial directory setup activities.
init-dirs: $(INIT_DIRS)
#	@printf "Setting up directory tree rooted in ./$(PROJECT)..."
#	@if [ ! -d "$(PROJECT)" ]; then \
#		mkdir -p $(@D) ./$(PROJECT)/{$(SOURCES),$(RESOURCES)} \
#		&& printf "$(DONE)" \
#		|| printf "$(FAILED)" \
#	else \
#		printf "$(IGNORE)"; \
#	fi

# ==============================================================================
# Makefiles
# ==============================================================================

include $(MAKEFILE_DIR)/main.mk
include $(MAKEFILE_DIR)/cookiecutter.mk

include $(MAKEFILE_DIR)/common.mk
include $(MAKEFILE_DIR)/git.mk

include $(MAKEFILE_DIR)/GitHub.mk
include $(MAKEFILE_DIR)/Swift.mk
include $(MAKEFILE_DIR)/Xcode.mk
