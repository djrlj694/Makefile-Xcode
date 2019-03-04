# git.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: git.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.1.0
# CREATED: 04FEB2019
# REVISED: 04MAR2019
# ==============================================================================

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
# Prerequisite phony targets for the "clean" target
# ------------------------------------------------------------------------------

.PHONY: clean-git

clean-git: | $(LOG) ## Completes all git cleanup activities.
	@printf "Removing git setup..."
	@rm -rf .git .gitignore >$(LOG) 2>&1; \
	$(RESULT)

# ------------------------------------------------------------------------------
# Prerequisite phony targets for the "init" target
# ------------------------------------------------------------------------------

.PHONY: init-git

init-git:  .gitignore .git | $(LOG) ## Completes all initial git setup activities.
	@printf "Committing the initial project to the master branch..."
	@git checkout -b master >$(LOG) 2>&1; \
	git add . >>$(LOG) 2>&1; \
	git commit -m "Initial project setup" >>$(LOG) 2>&1; \
	$(RESULT)
	@printf "Syncing the initial project with the origin..."
	@git remote add origin $(ORIGIN_URL) >$(LOG) 2>&1; \
	git push -u origin master >$(LOG) 2>&1; \
	$(RESULT)

# ==============================================================================
# File Targets
# ==============================================================================

.git: | $(LOG) ## Makes a git repository.
	@printf "Initializing git repository..."
	@git init >$(LOG) 2>&1; \
	$(RESULT)

.gitignore: .gitignore.download ## Makes a .gitignore file.

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
