# Xcode.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: Xcode.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.1.0
# CREATED: 04FEB2019
# REVISED: 06MAR2019
# ==============================================================================

# ==============================================================================
# Variables
# ==============================================================================

# ------------------------------------------------------------------------------
# Directories
# ------------------------------------------------------------------------------

XCODE_RESOURCES = Data Fonts Localization Media UserInterfaces
XCODE_RESOURCES_DIRS = $(addprefix $(PACKAGE)/Resources/,$(XCODE_RESOURCES))

XCODE_SOURCES = Controllers Extensions Models Protocols ViewModels Views
XCODE_SOURCES_DIRS = $(addprefix $(PACKAGE)/Sources/,$(XCODE_SOURCES))

XCODE_DIRS = $(addsuffix /.,$(XCODE_RESOURCES_DIRS) $(XCODE_SOURCES_DIRS))
#XCODE_DIRS = $(XCODE_RESOURCES_DIRS) $(XCODE_SOURCES_DIRS)

# ------------------------------------------------------------------------------
# Test strings
# ------------------------------------------------------------------------------

define XCODE_DIRS_TEST
.
./.git
./.github
./.github/ISSUE_TEMPLATE
./.github/PULL_REQUEST_TEMPLATE
./$(PACKAGE)
./$(PACKAGE)/Resources
./$(PACKAGE)/Resources/Data
./$(PACKAGE)/Resources/Fonts
./$(PACKAGE)/Resources/Localization
./$(PACKAGE)/Resources/Media
./$(PACKAGE)/Resources/UserInterfaces
./$(PACKAGE)/Sources
./$(PACKAGE)/Sources/Controllers
./$(PACKAGE)/Sources/Extensions
./$(PACKAGE)/Sources/Models
./$(PACKAGE)/Sources/Protocols
./$(PACKAGE)/Sources/ViewModels
./$(PACKAGE)/Sources/Views
endef
export XCODE_DIRS_TEST

define XCODE_FILES_TEST
./.github/ISSUE_TEMPLATE/ISSUE_TEMPLATE.md
./.github/ISSUE_TEMPLATE/bug_report.md
./.github/ISSUE_TEMPLATE/custom.md
./.github/ISSUE_TEMPLATE/feature_request.md
./.github/PULL_REQUEST_TEMPLATE/pull_request_template.md
./.gitignore
./CHANGELOG.md
./CODE_OF_CONDUCT.md
./CONTRIBUTING.md
./Cartfile
./Cartfile.private
./Framework.podspec
./README.md
./REFERENCES.md
./SUPPORT.md
endef
export XCODE_FILES_TEST

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
# Prerequisite phony targets for the "clean" target
# ------------------------------------------------------------------------------

#.PHONY: clean-xcode clean-xcode-dirs clean-docs-xcode
.PHONY: clean-xcode clean-xcode-dirs

#clean-xcode: clean-docs-xcode ## Completes all Xcode cleanup activities.
clean-xcode: clean-carthage clean-cocoapods clean-xcode-dirs ## Completes all Xcode cleanup activities.
	@printf "Removing Xcode setup..."
	@rm -rf $(PACKAGE) >$(LOG) 2>&1; \
	$(STATUS_RESULT)

# ------------------------------------------------------------------------------
# Prerequisite phony targets for the "init" target
# ------------------------------------------------------------------------------

.PHONY: init-xcode init-xcode-dirs init-xcode-vars

## init-xcode: Completes all initial Xcode setup activites.
ifneq ($(COOKIECUTTER),)
init-xcode: init-xcode-vars init-xcode-dirs init-carthage init-cocoapods ## Completes all initial Xcode setup activites.
else
init-xcode: init-xcode-vars init-xcode-dirs init-carthage init-cocoapods ## Completes all initial Xcode setup activites.
endif

## init-xcode-dirs: Completes all initial Xcode directory setup activites.
init-xcode-dirs: $(XCODE_DIRS)

## init-xcode-vars: Completes all Xcode variable setup activites.
init-xcode-vars:
	$(eval TEMPLATES_REPO = $(GITHUB_USER)/Cookiecutter-Xcode)
	$(eval FILE_URL = https://raw.githubusercontent.com/$(TEMPLATES_REPO)/master/%7B%7Bcookiecutter.project_name%7D%7D)

# ------------------------------------------------------------------------------
# Prerequisite phony targets for the "test" target
# ------------------------------------------------------------------------------

.PHONY: test-xcode test-xcode-dirs test-xcode-files

## test-xcode: Completes all Xcode test activites.
test-xcode: test-xcode-dirs test-xcode-files

## test-xcode-dirs: Test Xcode directory setup.
test-xcode-dirs: expected_xcode_dirs.txt actual_xcode_dirs.txt | $(LOG)
	@printf "Testing Xcode directory setup..."
	@diff expected_xcode_dirs.txt actual_xcode_dirs.txt >$(LOG) 2>&1; \
	$(TEST_RESULT)

## test-xcode-files: Test Xcode file setup.
test-xcode-files: expected_xcode_files.txt actual_xcode_files.txt | $(LOG)
	@printf "Testing Xcode file setup..."
	@diff expected_xcode_files.txt actual_xcode_files.txt >$(LOG) 2>&1; \
	$(TEST_RESULT)

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

.INTERMEDIATE: actual_xcode_dirs.txt actual_xcode_files.txt expected_xcode_dirs.txt expected_xcode_files.txt

# Makes a temporary file listing expected.
actual_xcode_dirs.txt:
#	@printf "Making file $(TARGET_VAR).\n"
	@find . -type d -not -path "./.git/*" | sort >$@

# Makes a temporary file listing expected.
actual_xcode_files.txt:
#	@printf "Making file $(TARGET_VAR).\n"
	@find . -type f -not \( -path "./.git/*" -or -path "./make.log" -or -path "./*_dirs.txt" -or -path "./*_files.txt" \) | sort >$@

# Makes a temporary file listing expected.
expected_xcode_dirs.txt:
#	@printf "Making file $(TARGET_VAR).\n"
	@echo "$$XCODE_DIRS_TEST" >$@

# Makes a temporary file listing expected.
expected_xcode_files.txt:
#	@printf "Making file $(TARGET_VAR).\n"
	@echo "$$XCODE_FILES_TEST" >$@

# ==============================================================================
# Makefiles
# ==============================================================================

include $(MAKEFILE_DIR)/Carthage.mk
include $(MAKEFILE_DIR)/CocoaPods.mk
