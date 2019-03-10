# cookiecutter.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: cookiecutter.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0.0
# CREATED: 10MAR2019
# REVISED: 10MAR2019
# ==============================================================================

# ==============================================================================
# External Constants
#
# An external constant represents a variable that is intended to:
#
# 1. Have a fixed value;
# 2. Be set at the command line or by the environment.
#
# Typically, its right-hand side is conditionally expanded -- i.e., it is
# evaluated only if a value for the variable has not been set. As such, it is
# defined using the "?=" assignment operator. By convention, external variables
# are written in uppercase.
# ==============================================================================

# ------------------------------------------------------------------------------
# Command Output
# ------------------------------------------------------------------------------

COOKIECUTTER ?= $(shell which cookiecutter)

# ==============================================================================
# Internal Variables
#
# An internal variable represents a variable that is intended to:
#
# 1. Have a value that depends on other variables, shell commands, etc. in its
#    definition;
# 2. Be set within a makefile (i.e., the "Makefile" itself or an "include"-ed
#    ".mk" file).
#
# Typically, its right-hand side is recursively expanded -- i.e.,
# right-hand side evaluation is deferred until the variable is used. As such, it
# is defined using the "=" assignment operator. By convention, internal
# variables are lowercase words, separated by underscores.
# ==============================================================================

# ------------------------------------------------------------------------------
# Sed Commands
# ------------------------------------------------------------------------------

ifneq ($(COOKIECUTTER),)
PROJECT_CMD = $(call sed-cmd,project_name,$(PROJECT))
EMAIL_CMD = $(call sed-cmd,email,$(EMAIL))
GITHUB_USER_CMD = $(call sed-cmd,github_user,$(GITHUB_USER))
TRAVIS_USER_CMD = $(call sed-cmd,travis_user,$(TRAVIS_USER))
endif

# ==============================================================================
# Macros
#
# A macro is a convenient way of defining a multi-line variable. Although the
# terms "macro" and "variable" are uused interchangeably in the GNU "make"
# manual, "macro" here will mean a variable that is defined using the "define"
# directive, not one that is defined using an asignment operator. By convention,
# macros are written in lowercase, and their words are separated by underscores.
# ==============================================================================

ifneq ($(COOKIECUTTER),)
define update-file
	@sed -f $< $@ > $@.tmp
	@mv $@.tmp $@
endef
endif

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

# $(call sed-cmd,template-var,replacement)
# Generates a sed command for replacing Cookiecutter template variables with
# appropriate values.
ifneq ($(COOKIECUTTER),)
define sed-cmd
	's/{{ cookiecutter.$1 }}/$2/g'
endef
endif

# ==============================================================================
# Directory Targets
# ==============================================================================

# Makes a directory tree.
ifneq ($(COOKIECUTTER),)
%/.: | $(LOG)
	@printf "Making directory tree $(DIR_VAR)..."
	@mkdir -p $(@D) >$(LOG) 2>&1; \
	$(STATUS_RESULT)
endif

# ==============================================================================
# File Targets
# ==============================================================================

# Downloads a file.
# https://stackoverflow.com/questions/32672222/how-to-download-a-file-only-if-more-recently-changed-in-makefile
ifneq ($(COOKIECUTTER),)
%.download: | $(LOG) 
#	$(eval FILE = $(basename $@))
	@printf "Downloading file $(FILE_VAR)..."
	@curl -s -S -L -f $(FILE_URL)/$(FILE) -z $(FILE) -o $@ >$(LOG) 2>&1; \
	mv -n $@ $(FILE) >>$(LOG) 2>&1; \
	$(STATUS_RESULT)
endif

# Makes a special empty file for marking that a directory tree has been generated.
#ifneq ($(COOKIECUTTER),)
#%/.gitkeep:
#	@printf "Making directory tree for marker file $(TARGET_VAR)..."
#	@printf "Making marker file $(TARGET_VAR) and its directory tree..."
#	@mkdir -p $(@D); $(STATUS_RESULT)
#	@printf "Making marker file $(TARGET_VAR)..."
#	@touch $@; $(STATUS_RESULT)
#endif

# ==============================================================================
# Second Expansion Targets
# ==============================================================================

.SECONDEXPANSION:
#$(PREFIX)/%.dummy: $$(@D)/.gitkeep | $$(@D)/. ## Make a directory tree.
