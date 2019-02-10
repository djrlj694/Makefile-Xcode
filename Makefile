# Makefile
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: Makefile
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0
# CREATED: 04FEB2019
# REVISED: ---
# ==============================================================================

# ==============================================================================
# Variables
# ==============================================================================

# Settings

SHELL = bash

# Special Characters

EMPTY =
SPACE = $(EMPTY) $(EMPTY)

# Accounts

USER = $(shell whoami)

GITHUB_USER := $(if $(GITHUB_USER),$(GITHUB_USER),$(USER))

# Commands

RESULT = ([ $$? -eq 0 ] && printf "$(DONE)") || printf "$(FAILED)"
#RESULT = ([ $$? -eq 0 ] && printf "$(DONE)") || (printf "$(FAILED)" && cat $(LOG))

MKDIR = mkdir -p $(dir $@) && $(RESULT)
TOUCH = touch $@ && $(RESULT)

# Debugging & Error Capture

CUSTOM_VARIABLES = GITHUB_USER ORIGIN PREFIX PROJECT RESOURCES_DIRS SOURCES_DIRS USER

#LOG = $(shell mktemp /tmp/log.XXXXXXXXXX)
#LOG = `mktemp /tmp/log.XXXXXXXXXX`
#LOG = $(shell mktemp -t /tmp make.log.XXXXXXXXXX)
#LOG = $(shell mktemp)
LOG = /tmp/make.$$$$.log

ERROR = $(shell cat $(LOG))

LOG_ERROR = 2>$(LOG); $(RESULT); cat $(LOG); rm $(LOG)

# Directories

PREFIX = $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))
PROJECT = $(basename $(PREFIX))

SOURCES = Controllers Extensions Models Protocols ViewModels Views
RESOURCES = Data Fonts Localization Media UserInterfaces

SOURCES_DIRS = $(addprefix $(PROJECT)/Sources/,$(SOURCES))
RESOURCES_DIRS = $(addprefix $(PROJECT)/Resources/,$(RESOURCES))
DIRS = $(SOURCES_DIRS) $(RESOURCES_DIRS)

# Files

# Used to create special empty ("marker") files in order to:
# 1. Automaticcally create directory trees if they don't already exist;
# 2. Avoid directory tree rebuilds as their directory timestamps changed.
DUMMY_FILES = $(addsuffix /.dummy,$(DIRS))

MD_FILES = CHANGELOG.md CONTRIBUTING.md ISSUE_TEMPLATE.md

# URLs

GITHUB = https://raw.githubusercontent.com/$(USER)/makefile-xcode/master/templates
ORIGIN = https://github.com/$(USER)/$(PROJECT).git

# STDOUT format settings

RESET = \033[0m
BOLD = \033[1m
DIM = \033[2m

FG_CYAN = \033[0;36m
FG_GREEN = \033[0;32m
FG_RED = \033[0;31m
FG_YELLOW = \033[1;33m

# Help strings

PREFIX_ARG = $(FG_CYAN)<prefix>$(RESET)
TARGET_ARG = $(FG_CYAN)<target>$(RESET)
USER_ARG = $(FG_CYAN)<user>$(RESET)

MAKE = make $(TARGET_ARG) [PREFIX=$(PREFIX_ARG)] [USER=$(USER_ARG)]

define HELP1

Usage:
  $(MAKE)

Targets:

endef
export HELP1

HELP2 = $(FG_CYAN)%-17s$(RESET) %s

# Path strings

TARGET_VAR = $(FG_CYAN)$@$(RESET)

# Result strings

DONE = $(FG_GREEN)done$(RESET).\n
FAILED = $(FG_RED)failed$(RESET).\n
IGNORE = $(FG_YELLOW)ignore$(RESET).\n

# ==============================================================================
# Phony Targets
#
# Phony targets exist for convenience.  That is, their commands won't run if a
# file of the same name exists.
# ==============================================================================

.PHONY: all build clean dirs docs git md setup test vars-all vars-some

#dirs: ## Make a directory structure.
#	@printf "Setting up directory tree rooted in ./$(PROJECT)..."
#	@if [ ! -d "$(PROJECT)" ]; then \
#		$(MKDIR) ./$(PROJECT)/{$(SOURCES),$(RESOURCES)} \
#		&& printf "$(DONE)" \
#		|| printf "$(FAILED)" \
#	else \
#		printf "$(IGNORE)"; \
#	fi
dirs: $(DUMMY_FILES) ## Complete all directory setup activities.

docs: ## Make API documentation.
	@printf "Generating API documentation..."
	@jazzy \
		--min-acl internal \
		--no-hide-documentation-coverage \
		--theme fullwidth \
		--output ./docs \
            	--documentation=./*.md \
		&& printf "$(DONE)" \
		|| printf "$(FAILED)"
	@rm -rf ./build

git: .gitignore .git ## Complete all git setup activities.
	@printf "Committing the initial project to the master branch..."
	@git checkout -q -b master
	@git add .
	@git commit -q -m "Initial project setup"
	@printf "$(DONE)"
	@echo "LOG = $(LOG)"
	@printf "Syncing the initial project with the origin..."
	@git remote add origin $(ORIGIN)
	@git push -u origin master $(LOG_ERROR)

help: ## Show usage documentation.
	@printf "$$HELP1"
	@egrep '^[a-zA-Z_-]+:.*?##' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "  $(HELP2)\n", $$1, $$2}'
	@echo ""

setup: md dirs git ## Complete all Xcode project setup activities.

md: $(MD_FILES) ## Make all Markdown files.

test: vars-some ## Complete all test activities.
	tree $(PREFIX)

vars-all: ## Show all Makefile variables (i.e., built-in and custom).
	@echo
	$(foreach v, $(.VARIABLES), $(info $(v) = $($(v))))

vars-some: ## Show only a few custom Makefile variables.
	@echo
	$(foreach v, $(CUSTOM_VARIABLES), $(info $(v) = $($(v))))

# ==============================================================================
# Second Expansion Targets
# ==============================================================================

.SECONDEXPANSION:
$(PREFIX)/%.dummy: $$(@D)/.dummy | $$(@D)/. ## Make a directory tree.

# ==============================================================================
# Real Targets
#
# Real targets correspond to files and directories to make.
# ==============================================================================

# https://stackoverflow.com/questions/32672222/how-to-download-a-file-only-if-more-recently-changed-in-makefile
%.download: ## Downloads a file.
	$(eval FILE = $(basename $@))
	@printf "Downloading file $(FILE)..."
	@curl -s -S -L -f $(GITHUB)/$(FILE) -z $(FILE) -o $@ $(LOG_ERROR)
#	@curl -O -s -z $@ $(GITHUB)/$@ && $(RESULT)

%.md: ## Makes a Markdown template file.
	@printf "Moving file $@.downfile to $@..."
	@mv -n $@.download $@ $(LOG_ERROR)

%/.dummy: ## Generates a directory tree.
	@printf "Making directory tree for marker file $(TARGET_VAR)..."
	@$(MKDIR)
	@printf "Making marker file $(TARGET_VAR)..."
	@$(TOUCH)

.git: ## Makes a git repository.
	@printf "Initializing git repository..."
	@git init -q && $(RESULT)

.gitignore: .gitignore.download ## Makes a .gitignore file.
	@printf "Moving file $@.download to $@..."
	@mv -n $@.download $@ $(LOG_ERROR)

CHANGELOG.md: CHANGELOG.md.download ## Makes a CHANGELOG.md file.

CONTRIBUTING.md: CONTRIBUTING.md.download ## Makes a CONTRIBUTING.md file.

ISSUE_TEMPLATE.md: ISSUE_TEMPLATE.md.download ## Makes a ISSUE_TEMPLATE.md file.
