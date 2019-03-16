# main.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: main.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0.0
# CREATED: 07MAR2019
# REVISED: 16MAR2019
#
# NOTES:
#   For more info on terminology, style conventions, or source references, see
#   the file ".make/README.md".
# ==============================================================================

# ==============================================================================
# Feature Dependencies
# ==============================================================================

include $(MAKEFILE_DIR)/features/formatting.mk

include $(MAKEFILE_DIR)/features/debugging.mk
include $(MAKEFILE_DIR)/features/helping.mk

# ==============================================================================
# Internal Constants
# ==============================================================================

# ------------------------------------------------------------------------------
# Commands
# ------------------------------------------------------------------------------

# A shortcut representing the "mkdir" command with the "-p" option.
MKDIR := mkdir -p

# ------------------------------------------------------------------------------
# Files
# ------------------------------------------------------------------------------

#LOG = $(shell mktemp /tmp/log.XXXXXXXXXX)
#LOG = `mktemp /tmp/log.XXXXXXXXXX`
#LOG = $(shell mktemp -t /tmp make.log.XXXXXXXXXX)
#LOG = $(shell mktemp)
#LOG = /tmp/make.$$$$.log
LOG := make.log

# ------------------------------------------------------------------------------
# Settings
# ------------------------------------------------------------------------------

SHELL := bash

# ==============================================================================
# Internal Variables
# ==============================================================================

# ------------------------------------------------------------------------------
# Directories
# ------------------------------------------------------------------------------

# Name of the subdirectory, represented by the current Makefile target being
# run. The shell command "basename" removes the parent directory, $(@D)), from
# the absolute path of the makefile target.
subdir = $(shell basename $(@D))

# ------------------------------------------------------------------------------
# Files
# ------------------------------------------------------------------------------

file = $(basename $@)

# ------------------------------------------------------------------------------
# Path strings
# ------------------------------------------------------------------------------

dir_var = $(FG_CYAN)$(@D)$(RESET)
###file_var = $(FG_CYAN)$(file)$(RESET) # RLJ: Commented out. 23FEEB2019, RRLJ
file_var = $(FG_CYAN)$(@F)$(RESET)
subdir_var = $(FG_CYAN)$(subdir)$(RESET)

# Color-formatted name of the current makefile target being run.
target_var = $(FG_CYAN)$@$(RESET)

# ==============================================================================
# Directory Targets
# ==============================================================================

# Makes a directory tree.
#%/.: | $(LOG)
#	@printf "Making directory tree $(dir_var)..."
#	@mkdir -p $(@D) >$(LOG) 2>&1; \
#	$(status_result)

# ==============================================================================
# File Targets
# ==============================================================================

# Downloads a file.
# https://stackoverflow.com/questions/32672222/how-to-download-a-file-only-if-more-recently-changed-in-makefile
#%.download: | $(LOG) 
##	$(eval FILE = $(basename $@))
#	@printf "Downloading file $(file_var)..."
#	@curl -s -S -L -f $(FILE_URL)/$(FILE) -z $(FILE) -o $@ >$(LOG) 2>&1; \
#	mv -n $@ $(FILE) >>$(LOG) 2>&1; \
#	$(status_result)

# Makes a special empty file for marking that a directory tree has been generated.
#%/.gitkeep:
#	@printf "Making directory tree for marker file $(target_var)..."
#	@printf "Making marker file $(target_var) and its directory tree..."
#	@mkdir -p $(@D); $(status_result)
#	@printf "Making marker file $(target_var)..."
#	@touch $@; $(status_result)

# ==============================================================================
# Second Expansion Targets
# ==============================================================================

.SECONDEXPANSION:
#$(PREFIX)/%.gitkeep: $$(@D)/.gitkeep | $$(@D)/. ## Make a directory tree.
