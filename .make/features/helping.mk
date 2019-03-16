# helping.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: helping.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0.0
# CREATED: 16MAR2019
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
# Help strings
# ------------------------------------------------------------------------------

# Color-formatted arguments displayed as part of the online help in the Usage
# section of the "make" command when used with this makefile.
PACKAGE_ARG := $(FG_CYAN)<package>$(RESET)
PREFIX_ARG := $(FG_CYAN)<prefix>$(RESET)
TARGET_ARG := $(FG_CYAN)<target>$(RESET)
USER_ARG := $(FG_CYAN)<user>$(RESET)

# Argument syntax for the "make" command when used with this makefile.
MAKE_ARGS := [PACKAGE=$(PACKAGE_ARG)] [PREFIX=$(PREFIX_ARG)] [USER=$(USER_ARG)]

# ==============================================================================
# Internal Variables
# ==============================================================================

# ------------------------------------------------------------------------------
# Help strings
# ------------------------------------------------------------------------------

# Line item iin the "Targets" section of the online help for the "make" command
# when used with this makefile set.
target_help = $(FG_CYAN)%-17s$(RESET) %s

# ==============================================================================
# Macros
# ==============================================================================

# ------------------------------------------------------------------------------
# Help strings
# ------------------------------------------------------------------------------

# Targets section of the "make" command's online help for this makefile set.
define targets_help

Targets:

endef
export targets_help

# Usage section of the "make" command's online help for makefile set.
define usage_help

Usage:
  make = make $(TARGET_ARG) $(MAKE_ARGS)

endef
export usage_help

# ==============================================================================
# Phony Targets
# ==============================================================================

# ------------------------------------------------------------------------------
# Main phony targets
# ------------------------------------------------------------------------------

.PHONY: help

## help: Shows "make" usage documentation.
help:
	@printf "$$usage_help"
	@printf "$$targets_help"
#	@cat $(MAKEFILE_LIST) | \
#	egrep '^[a-zA-Z_-]+:.*?##' | \
#	sed -e 's/:.* ##/: ##/' | sort -d | \
#	awk 'BEGIN {FS = ":.*?## "}; {printf "  $(target_help)\n", $$1, $$2}'
	@cat $(MAKEFILE_LIST) | \
	egrep '^## [a-zA-Z_-]+: ' | sed -e 's/## //' | sort -d | \
	awk 'BEGIN {FS = ": "}; {printf "  $(target_help)\n", $$1, $$2}'
	@echo ""
