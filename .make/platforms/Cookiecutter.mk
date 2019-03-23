# Cookiecutter.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: Cookiecutter.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0.0
# CREATED: 10MAR2019
# REVISED: 21MAR2019
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

# $(call sed-cmd,cc_var,replacement)
# Generates a sed command for substituting a Cookiecutter template variable with
# a replacement value.
ifeq ($(COOKIECUTTER),)
cc-sed-cmd = s/{{ cookiecutter.$1 }}/$2/g
endif

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
