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

XCODE_RESOURCES = Data Fonts Localization Media UserInterfaces
XCODE_RESOURCES_DIRS = $(addprefix $(PROJECT)/Resources/,$(XCODE_RESOURCES))

XCODE_SOURCES = Controllers Extensions Models Protocols ViewModels Views
XCODE_SOURCES_DIRS = $(addprefix $(PROJECT)/Sources/,$(XCODE_SOURCES))

XCODE_DIRS = $(addsuffix /.,$(XCODE_RESOURCES_DIRS) $(XCODE_SOURCES_DIRS))

# ==============================================================================
# Macros
# ==============================================================================

define update-xcode-file
	@sed -e 's/{{ cookiecutter.project_name }}/$(PROJECT)/g' $@ >$@.tmp1
	@sed -e 's/{{ cookiecutter.github_user }}/$(GITHUB_USER)/g' $@.tmp1 >$@.tmp2
	@sed -e 's/{{ cookiecutter.email }}/$(EMAIL)/g' $@.tmp2 >$@.tmp3
	@sed -e 's/{{ cookiecutter.github_user }}/$(GITHUB_USER)/g' $@.tmp3 >$@.tmp4
	@sed -e 's/{{ cookiecutter.travis_user }}/$(TRAVIS_USER)/g' $@.tmp4 >$@
	@rm -rf $@.tmp*
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
# Prerequisite phony targets for cleaning activities
# ------------------------------------------------------------------------------

.PHONY: clean-xcode clean-docs-xcode

clean-xcode: clean-docs-xcode ## Completes all Xocde cleanup activities.

clean-docs-xcode: | $(LOG) ## Completes all Xcode Markdown cleanup activities.
	@printf "Removing Xcode documents..."
	@rm -rf $(XCODE_FILES) 2>&1; \
	$(RESULT)

# ------------------------------------------------------------------------------
# Prerequisite phony targets for document generation activities
# ------------------------------------------------------------------------------

.PHONY: docs-xcode 

docs-xcode: $(XCODE_FILES) ## Completes all GitHub document generation activites.

# ------------------------------------------------------------------------------
# Prerequisite phony targets for initial setup activities
# ------------------------------------------------------------------------------

.PHONY: init-xcode init-xcode-dirs init-xcode-vars

init-xcode: init-xcode-vars init-xcode-dirs docs-xcode init-carthage init-cocoapods ## Completes all initial Xcode setup activites.

init-xcode-dirs: $(XCODE_DIRS)

init-xcode-vars: ## Completes all Xcode variable setup activites.
	$(eval TEMPLATES_REPO = $(GITHUB_USER)/Cookiecutter-Xcode)
	$(eval FILE_URL = https://raw.githubusercontent.com/$(TEMPLATES_REPO)/master/%7B%7Bcookiecutter.project_name%7D%7D)

# ==============================================================================
# Makefiles
# ==============================================================================

include $(MAKEFILE_DIR)/Carthage.mk
include $(MAKEFILE_DIR)/CocoaPods.mk
