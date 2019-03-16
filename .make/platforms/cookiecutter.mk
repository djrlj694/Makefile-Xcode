# cookiecutter.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: cookiecutter.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0.0
# CREATED: 10MAR2019
# REVISED: 16MAR2019
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
# Internal Variables
# ==============================================================================

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
# Macros
# ==============================================================================

ifeq ($(COOKIECUTTER),)
define update-file
	@sed -f $< $@ > $@.tmp
	@mv $@.tmp $@
endef
endif

# ==============================================================================
# User-Defined Functions
# ==============================================================================

# $(call sed-cmd,template-var,replacement)
# Generates a sed command for replacing Cookiecutter template variables with
# appropriate values.
ifeq ($(COOKIECUTTER),)
define sed-cmd
	's/{{ cookiecutter.$1 }}/$2/g'
endef
endif

# ==============================================================================
# Directory Targets
# ==============================================================================

# Makes a directory tree.
ifeq ($(COOKIECUTTER),)
%/.: | $(LOG)
	@printf "Making directory tree $(dir_var)..."
	@mkdir -p $(@D) >$(LOG) 2>&1; \
	$(status_result)
endif

# ==============================================================================
# File Targets
# ==============================================================================

# Makes a special empty file for marking that a directory tree has been generated.
#ifneq ($(COOKIECUTTER),)
#%/.gitkeep:
#	@printf "Making directory tree for marker file $(target_var)..."
#	@printf "Making marker file $(target_var) and its directory tree..."
#	@mkdir -p $(@D); $(status_result)
#	@printf "Making marker file $(target_var)..."
#	@touch $@; $(status_result)
#endif

# ==============================================================================
# Second Expansion Targets
# ==============================================================================

.SECONDEXPANSION:
#$(PREFIX)/%.dummy: $$(@D)/.gitkeep | $$(@D)/. ## Make a directory tree.
