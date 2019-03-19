# helping.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: helping.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0.0
# CREATED: 16MAR2019
# REVISED: 19MAR2019
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

# Argument syntax for the "make [help]" command for this makefile set.
MAKE_ARGS := [$(FG_CYAN)<target>$(RESET)]

# ==============================================================================
# Internal Variables
# ==============================================================================

# ------------------------------------------------------------------------------
# Help strings
# ------------------------------------------------------------------------------

# "Targets" section line item of the online help for the "make [help]" command
# for this makefile set.
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
  make = make $(FG_CYAN)<target>$(RESET) $(MAKE_ARGS)

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
