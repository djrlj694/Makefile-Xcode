# cookiecutter.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: cookiecutter.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0.0
# CREATED: 10MAR2019
# REVISED: 18MAR2019
#
# NOTES:
#   For more info on terminology, style conventions, or source references, see
#   the file ".make/README.md".
# ==============================================================================

# ==============================================================================
# External Constants
# ==============================================================================

# ------------------------------------------------------------------------------
# Command output
# ------------------------------------------------------------------------------

COOKIECUTTER ?= $(shell which cookiecutter)

# ==============================================================================
# Internal Constants
## ==============================================================================

# ------------------------------------------------------------------------------
# Debugging & error capture
# ------------------------------------------------------------------------------

VARIABLES_TO_SHOW += COOKIECUTTER

# ------------------------------------------------------------------------------
# Help strings
# ------------------------------------------------------------------------------

MAKE_ARGS += [COOKIECUTTER=]

# ==============================================================================
# User-Defined Functions
# ==============================================================================

# $(call add-cc-sed-cmds,cc_vars)
# Generates a sed command for replacing Cookiecutter template variables with
# appropriate values.
# Generates sed commands for substituting the replacement string for the 1st
# instance of the Cookiecutter template variable in the pattern space.
add-cc-sed-cmds = $(foreach cc_var,$1,$(call add-cc-sed-cmd,$(cc_var)))

# ==============================================================================
# Feature Dependencies
# ==============================================================================

ifeq ($(COOKIECUTTER),)
include $(MAKEFILE_DIR)/features/downloading.mk
include $(MAKEFILE_DIR)/features/setting_up.mk
endif

# ==============================================================================
# Platform Dependencies
# ==============================================================================

ifeq ($(COOKIECUTTER),)
include $(MAKEFILE_DIR)/platforms/sed.mk
endif
