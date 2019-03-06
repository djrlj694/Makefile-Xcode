# Makefile
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: Makefile
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.1.0
# CREATED: 04FEB2019
# REVISED: 06MAR2019
# ==============================================================================

# .ONESHELL:
# .EXPORT_ALL_VARIABLES:

# ==============================================================================
# Variables
# ==============================================================================

# ------------------------------------------------------------------------------
# Settings
# ------------------------------------------------------------------------------

SHELL = bash

# ------------------------------------------------------------------------------
# Special Characters
# ------------------------------------------------------------------------------

EMPTY =
SPACE = $(EMPTY) $(EMPTY)

# ------------------------------------------------------------------------------
# Accounts
# ------------------------------------------------------------------------------

USER = $(shell whoami)

# ------------------------------------------------------------------------------
# Command Output
# ------------------------------------------------------------------------------

COOKIECUTTER = $(shell which cookiecutter)

# ------------------------------------------------------------------------------
# Commands
# ------------------------------------------------------------------------------

MKDIR = mkdir -p

# ------------------------------------------------------------------------------
# Debugging & Error Capture
# ------------------------------------------------------------------------------

STATUS_RESULT = $(call print-result,$(DONE))
TEST_RESULT = $(call print-result,$(PASSED))

VARIABLES_TO_SHOW = MAKEFILE MAKEFILE_DIR MAKEFILE_LIST PACKAGE PREFIX PROJECT PWD USER

# ------------------------------------------------------------------------------
# Directories
# ------------------------------------------------------------------------------

MAKEFILE_DIR = $(dir $(realpath $(MAKEFILE)))
PREFIX = $(PWD)
SUBDIR = $(shell basename $(@D))

PROJECT = $(shell basename $(PREFIX))
PACKAGE = $(PROJECT)

BIN_DIR = bin/.
LOG_DIR = logs/.
SETUP_DIRS = $(BIN_DIR) $(LOG_DIR)

# ------------------------------------------------------------------------------
# Files
# ------------------------------------------------------------------------------

FILE = $(basename $@)
MAKEFILE = $(firstword $(MAKEFILE_LIST))

# Used to create special empty ("marker") files in order to:
# 1. Automaticcally create directory trees if they don't already exist;
# 2. Avoid directory tree rebuilds as their directory timestamps changed.
###DUMMY_FILES = $(addsuffix /.dummy,$(DIRS)) # RLJ: Commented out. 23FEB2019

#LOG = $(shell mktemp /tmp/log.XXXXXXXXXX)
#LOG = `mktemp /tmp/log.XXXXXXXXXX`
#LOG = $(shell mktemp -t /tmp make.log.XXXXXXXXXX)
#LOG = $(shell mktemp)
#LOG = /tmp/make.$$$$.log
LOG = make.log

# ------------------------------------------------------------------------------
# STDOUT format settings
# ------------------------------------------------------------------------------

RESET = \033[0m
BOLD = \033[1m
DIM = \033[2m

FG_CYAN = \033[0;36m
FG_GREEN = \033[0;32m
FG_RED = \033[0;31m
FG_YELLOW = \033[1;33m

# ------------------------------------------------------------------------------
# Help strings
# ------------------------------------------------------------------------------

PACKAGE_ARG = $(FG_CYAN)<package>$(RESET)
PREFIX_ARG = $(FG_CYAN)<prefix>$(RESET)
TARGET_ARG = $(FG_CYAN)<target>$(RESET)
USER_ARG = $(FG_CYAN)<user>$(RESET)

MAKE = make $(TARGET_ARG) [PACKAGE=$(PACKAGE_ARG)] [PREFIX=$(PREFIX_ARG)] [USER=$(USER_ARG)]

define HELP1

Usage:
  $(MAKE)

Targets:

endef
export HELP1

HELP2 = $(FG_CYAN)%-17s$(RESET) %s

# ------------------------------------------------------------------------------
# Path strings
# ------------------------------------------------------------------------------

DIR_VAR = $(FG_CYAN)$(@D)$(RESET)
###FILE_VAR = $(FG_CYAN)$(FILE)$(RESET) # RLJ: Commented out. 23FEEB2019, RRLJ
FILE_VAR = $(FG_CYAN)$(@F)$(RESET)
SUBDIR_VAR = $(FG_CYAN)$(SUBDIR)$(RESET)

TARGET_VAR = $(FG_CYAN)$@$(RESET)

# ------------------------------------------------------------------------------
# Result strings
# ------------------------------------------------------------------------------

DONE = $(FG_GREEN)done$(RESET).\n
FAILED = $(FG_RED)failed$(RESET).\n
IGNORE = $(FG_YELLOW)ignore$(RESET).\n
PASSED = $(FG_GREEN)passed$(RESET).\n

# ==============================================================================
# User-Defined Functions
#
# A user-defined function is a variable or macro that includes one or more
# temporary variables ($1, $2, etc.) in its definition. By convention, user-
# defined function names use lowercase words separated by dashes.  For more
# info, see:
# 1. https://www.gnu.org/software/make/manual/html_node/Call-Function.html
# 2. https://www.oreilly.com/openbook/make3/book/ch11.pdf
# 3. https://www.oreilly.com/openbook/make3/book/ch04.pdf
# ==============================================================================

# $(call print-result, formatted-success-string)
#	Print success string -- $(DONE) or $(PASSED) if the most recent return code
#	value equals 0; otherwise, print $(FAILED) and the associated error message.
define print-result
	([ $$? -eq 0 ] && printf "$1") || \
	(printf "$(FAILED)\n" && cat $(LOG) && echo)
endef

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

.PHONY: all build clean debug docs log setup test

all: help

ifneq ($(PROJECT),Makefile-Xcode)
clean: clean-git clean-xcode clean-github clean-common clean-dirs ## Completes all cleaning activities.
endif

debug: debug-vars-some debug-dirs-tree debug-dirs-ll ## Completes all debugging activities.

docs: docs-swift ## Makes API documentation.

help: ## Shows usage documentation.
	@printf "$$HELP1"
	@cat $(MAKEFILE_LIST) | \
	egrep '^[a-zA-Z_-]+:.*?##' | \
	sed -e 's/:.* ##/: ##/' | sort -d | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "  $(HELP2)\n", $$1, $$2}'
	@echo ""

init: init-dirs init-github init-xcode init-common init-git ## Completes all initial repo setup activities.

log: ## Shows the most recently generated log for a specified release.
	@echo
	#@set -e; \
	#LOG==$$(ls -l $(LOGS_DIR)/* | head -1); \
	#printf "Showing the most recent log: $(LOG_FILE)\n"; \
	#echo; \
	#cat $$LOG
	printf "Showing the most recent log: $(LOG_FILE)\n"
	@echo
	@cat $(LOG_FILE)

test: vars-some ## Completes all test activities.
	tree $(PREFIX)

# ------------------------------------------------------------------------------
# Prerequisite phony targets for the "clean" target
# ------------------------------------------------------------------------------

.PHONY: clean-dirs

clean-dirs: | $(LOG) ## Completes all directory cleanup activities.
	@printf "Removing directories setup..."
	@rm -rf $(PROJECT) $(dir $(SETUP_DIRS)) >$(LOG) 2>&1; \
	$(STATUS_RESULT)

# ------------------------------------------------------------------------------
# Prerequisite phony targets for the "debug" target
# ------------------------------------------------------------------------------

.PHONY: debug-dirs-ll debug-dirs-tree debug-vars-all debug-vars-some

debug-dirs-ll: ## Shows the contents of directories in a "long listing" format.
	ls -alR $(PREFIX)

debug-dirs-tree: ## Shows the contents of directories in a tree-like format.
	tree $(PREFIX)

debug-vars-all: ## Shows all Makefile variables (i.e., built-in and custom).
	@echo
	$(foreach v, $(.VARIABLES), $(info $(v) = $($(v))))

debug-vars-some: ## Shows only a few custom Makefile variables.
	@echo
	$(foreach v, $(VARIABLES_TO_SHOW), $(info $(v) = $($(v))))

# ------------------------------------------------------------------------------
# Prerequisite phony targets for the "init" target
# ------------------------------------------------------------------------------

.PHONY: init-dirs

#dirs: ## Completes all directory setup activities.
#	@printf "Setting up directory tree rooted in ./$(PROJECT)..."
#	@if [ ! -d "$(PROJECT)" ]; then \
#		mkdir -p $(@D) ./$(PROJECT)/{$(SOURCES),$(RESOURCES)} \
#		&& printf "$(DONE)" \
#		|| printf "$(FAILED)" \
#	else \
#		printf "$(IGNORE)"; \
#	fi
#dirs: $(DUMMY_FILES) ## Completes all directory setup activities.
init-dirs: $(INIT_DIRS) ## Completes all initial directory setup activities.

# ------------------------------------------------------------------------------
# Prerequisite phony targets for the "test" target
# ------------------------------------------------------------------------------

# ==============================================================================
# Directory Targets
# ==============================================================================

%/.: | $(LOG) ## Makes a directory tree.
	@printf "Making directory tree $(DIR_VAR)..."
	@mkdir -p $(@D) >$(LOG) 2>&1; \
	$(STATUS_RESULT)

# ==============================================================================
# File Targets
# ==============================================================================

# https://stackoverflow.com/questions/32672222/how-to-download-a-file-only-if-more-recently-changed-in-makefile
%.download: | $(LOG) ## Downloads a file.
#	$(eval FILE = $(basename $@))
	@printf "Downloading file $(FILE_VAR)..."
	@curl -s -S -L -f $(FILE_URL)/$(FILE) -z $(FILE) -o $@ >$(LOG) 2>&1; \
	mv -n $@ $(FILE) >>$(LOG) 2>&1; \
	$(STATUS_RESULT)

#%/.dummy: ## Makes a special empty file for marking that a directory tree has been generated.
#	@printf "Making directory tree for marker file $(TARGET_VAR)..."
#	@printf "Making marker file $(TARGET_VAR) and its directory tree..."
#	@mkdir -p $(@D); $(STATUS_RESULT)
#	@printf "Making marker file $(TARGET_VAR)..."
#	@touch $@; $(STATUS_RESULT)

# ==============================================================================
# Intermediate Targets
#
# An intermediate target corresponds to a file that is needed on the way from a
# source file to a target file.  It typically is a temporary file that is needed
# only once to generate the target after the source changed.  The "make" command
# automatically removes files that are identified as intermediate targets.  In
# other words, such files that did not exist before a "make" run executed do not
# exist after a "make" run.
# ==============================================================================

.INTERMEDIATE: $(LOG)

$(LOG): ## Makes a temporary file capturring a shell command error.
	@touch $@

# ==============================================================================
# Second Expansion Targets
# ==============================================================================

.SECONDEXPANSION:
#$(PREFIX)/%.dummy: $$(@D)/.dummy | $$(@D)/. ## Make a directory tree.

# ==============================================================================
# Makefiles
# ==============================================================================

include $(MAKEFILE_DIR)/common.mk
include $(MAKEFILE_DIR)/git.mk
include $(MAKEFILE_DIR)/GitHub.mk
include $(MAKEFILE_DIR)/Swift.mk
include $(MAKEFILE_DIR)/Xcode.mk
