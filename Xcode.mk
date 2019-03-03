# Xcode.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: Xcode.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.1.0
# CREATED: 04FEB2019
# REVISED: 03MAR2019
# ==============================================================================

# ==============================================================================
# Variables
# ==============================================================================

# ------------------------------------------------------------------------------
# Directories
# ------------------------------------------------------------------------------

RESOURCES = Data Fonts Localization Media UserInterfaces
RESOURCES_DIRS = $(addprefix $(PROJECT)/Resources/,$(addsuffix /.,$(RESOURCES)))

SOURCES = Controllers Extensions Models Protocols ViewModels Views
SOURCES_DIRS = $(addprefix $(PROJECT)/Sources/,$(addsuffix /.,$(SOURCES)))

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
# Prerequisite phony targets for initial setup activities
# ------------------------------------------------------------------------------

.PHONY: init-xcode init-xcode-dirs init-xcode-vars

init-xcode: init-xcode-vars init-xcode-dirs init-carthage init-cocoapods ## Completes all initial Xcode setup activites.
	@echo "FILE_URL =  $(FILE_URL)"

init-xcode-dirs: $(RESOURCES_DIRS) $(SOURCES_DIRS)

init-xcode-vars: ## Completes all Xcode variable setup activites.
	$(eval TEMPLATES_REPO = $(GITHUB_USER)/Cookiecutter-Xcode)
	$(eval FILE_URL = https://raw.githubusercontent.com/$(TEMPLATES_REPO)/master/%7B%7Bcookiecutter.project_name%7D%7D)
