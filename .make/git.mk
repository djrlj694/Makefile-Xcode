# git.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: git.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.1.0
# CREATED: 04FEB2019
# REVISED: 11MAR2019
# ==============================================================================

# ==============================================================================
# Phony Targets
#
# A phony target is one that does not represent a file or directory. It can be
# thought of as an embedded shell script to be run when an explicit request
# is made unless uness a file of the same name exists.
#
# Two reasons to use a phony target are:
#
# 1. To avoid a conflict with a file of the same name;
# 2. To improve performance.
# ==============================================================================

# ------------------------------------------------------------------------------
# Prerequisite phony targets for the "clean" target
# ------------------------------------------------------------------------------

.PHONY: clean-git

## clean-git: Completes all git cleanup activities.
clean-git: | $(LOG)
	@printf "Removing git setup..."
	@rm -rf .git .gitignore >$(LOG) 2>&1; \
	$(status_result)

# ------------------------------------------------------------------------------
# Prerequisite phony targets for the "init" target
# ------------------------------------------------------------------------------

.PHONY: init-git

## init-git: Completes all initial git setup activities.
ifeq ($(COOKIECUTTER),)
init-git: .gitignore .git | $(LOG)
else
init-git: .git | $(LOG)
endif
	@printf "Committing the initial project to the master branch..."
	@git checkout -b master >$(LOG) 2>&1; \
	git add . >>$(LOG) 2>&1; \
	git commit -m "Initial project setup" >>$(LOG) 2>&1; \
	$(status_result)
	@printf "Syncing the initial project with the origin..."
	@git remote add origin $(ORIGIN_URL) >$(LOG) 2>&1; \
	git push -u origin master >$(LOG) 2>&1; \
	$(status_result)

# ==============================================================================
# Directory Targets
# ==============================================================================

## .git: Makes a git repository.
.git: | $(LOG)
	@printf "Initializing git repository..."
	@git init >$(LOG) 2>&1; \
	$(status_result)

# ==============================================================================
# File Targets
# ==============================================================================

## .gitignore: Makes a .gitignore file.
.gitignore: .gitignore.download

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

.INTERMEDIATE: .gitignore.download
