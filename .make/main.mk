# main.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: main.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0.0
# CREATED: 07MAR2019
# REVISED: 07MAR2019
# ==============================================================================

# ==============================================================================
# Variables
# ==============================================================================

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

STATUS_RESULT = $(call result,$(DONE))
TEST_RESULT = $(call result,$(PASSED))

VARIABLES_TO_SHOW = EMAIL_REGEX MAKEFILE MAKEFILE_DIR MAKEFILE_LIST PACKAGE PREFIX PROJECT PWD USER

# ------------------------------------------------------------------------------
# Directories
# ------------------------------------------------------------------------------

MAKEFILE_DIR = $(dir $(realpath $(MAKEFILE)))/.make
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

# $(call result, formatted-success-string)
#	Print success string -- $(DONE) or $(PASSED) -- if the most recent return
#	code value equals 0; otherwise, print $(FAILED) and the associated error
#	message.
define result
	([ $$? -eq 0 ] && printf "$1") || \
	(printf "$(FAILED)\n" && cat $(LOG) && echo)
endef
