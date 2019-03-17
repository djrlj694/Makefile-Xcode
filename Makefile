# Makefile
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: Makefile
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.1.0
# CREATED: 04FEB2019
# REVISED: 17MAR2019
#
# NOTES:
#   For more info on terminology, style conventions, or source references, see
#   the file ".make/README.md".
# ==============================================================================

# .ONESHELL:
# .EXPORT_ALL_VARIABLES:

# ==============================================================================
# External Constants
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
# ==============================================================================

# ------------------------------------------------------------------------------
# Settings
# ------------------------------------------------------------------------------

SHELL := bash

# ------------------------------------------------------------------------------
# Debugging & error capture
# ------------------------------------------------------------------------------

# A list of makefile variables to show when testing/debugging.
VARIABLES_TO_SHOW := MAKEFILE MAKEFILE_DIR MAKEFILE_LIST
VARIABLES_TO_SHOW += PACKAGE PREFIX PROJECT PWD USER

# ------------------------------------------------------------------------------
# Directories
# ------------------------------------------------------------------------------

BIN_DIR := bin/.
LOG_DIR := logs/.
SETUP_DIRS := $(BIN_DIR) $(LOG_DIR)

# ==============================================================================
# Internal Variables
# ==============================================================================

# ------------------------------------------------------------------------------
# Directories
# ------------------------------------------------------------------------------

# Absolute path of the directory containing files to be included as part of a
# makefile set.
MAKEFILE_DIR = $(dir $(realpath $(MAKEFILE)))/.make

# ------------------------------------------------------------------------------
# Files
# ------------------------------------------------------------------------------

# The name of the main makefile.
MAKEFILE = $(firstword $(MAKEFILE_LIST))

# Used to create special empty ("marker") files in order to:
# 1. Automatically create directory trees if they don't already exist;
# 2. Avoid directory tree rebuilds as their directory timestamps changed.
###DUMMY_FILES = $(addsuffix /.dummy,$(DIRS)) # RLJ: Commented out. 23FEB2019

# ------------------------------------------------------------------------------
# Sed commands
# ------------------------------------------------------------------------------

ifeq ($(COOKIECUTTER),)
PROJECT_CMD = $(call sed-cmd,project_name,$(PROJECT))
EMAIL_CMD = $(call sed-cmd,email,$(EMAIL))
GITHUB_USER_CMD = $(call sed-cmd,github_user,$(GITHUB_USER))
TRAVIS_USER_CMD = $(call sed-cmd,travis_user,$(TRAVIS_USER))
endif

# ==============================================================================
# User-Defined Functions
# ==============================================================================

# $(call add-sed-cmd,template-var,replacement)
# Generates a sed command for replacing Cookiecutter template variables with
# appropriate values.
define add-sed-cmd
	case $1 in \
		email) sed_cmd=$(call sed-cmd,$1,$(EMAIL));; \
		github_user) sed_cmd=$(call sed-cmd,$1,$(GITHUB_USER));; \
		project_name) sed_cmd=$(call sed-cmd,$1,$(PROJECT));; \
		travis_user) sed_cmd=$(call sed-cmd,$1,$(TRAVIS_USER));; \
	esac; \
	echo $$sed_cmd >> $@;
endef

# ==============================================================================
# Feature Dependencies
# ==============================================================================

include $(MAKEFILE_DIR)/features/formatting.mk

include $(MAKEFILE_DIR)/features/debugging.mk
include $(MAKEFILE_DIR)/features/helping.mk

include $(MAKEFILE_DIR)/features/common.mk

# ==============================================================================
# Phony Targets
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
# Platform Dependencies
# ==============================================================================

include $(MAKEFILE_DIR)/platforms/cookiecutter.mk
include $(MAKEFILE_DIR)/platforms/git.mk
include $(MAKEFILE_DIR)/platforms/GitHub.mk
include $(MAKEFILE_DIR)/platforms/Xcode.mk
