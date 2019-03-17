# cookiecutter.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: cookiecutter.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0.0
# CREATED: 10MAR2019
# REVISED: 17MAR2019
#
# NOTES:
#   For more info on terminology, style conventions, or source references, see
#   the file ".make/README.md".
# ==============================================================================

# ==============================================================================
# Feature Dependencies
# ==============================================================================

ifeq ($(COOKIECUTTER),)
include $(MAKEFILE_DIR)/features/downloading.mk
include $(MAKEFILE_DIR)/features/setting_up.mk
endif

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

# $(call sed-cmd,template-var,replacement)
# Generates a Cookiecutter template variable.
cc-var = {{ cookiecutter.$1 }}

# $(call sed-cmd,template-var,replacement)
# Generates a sed command for replacing Cookiecutter template variables with
# appropriate values.
define sed-cmd
	's/{{ cookiecutter.$1 }}/$2/g'
endef

# ==============================================================================
# Platform Dependencies
# ==============================================================================

ifeq ($(COOKIECUTTER),)
include $(MAKEFILE_DIR)/platforms/sed.mk
endif
