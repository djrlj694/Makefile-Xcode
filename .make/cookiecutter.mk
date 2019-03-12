# cookiecutter.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: cookiecutter.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0.0
# CREATED: 10MAR2019
# REVISED: 12MAR2019
# ==============================================================================

# ==============================================================================
# External Constants
#
# An external constant is a variable that is intended to:
#
# 1. Have a fixed value;
# 2. Be set at the command line or by the environment.
#
# It is typically defined using the "?=" assignment operator to "conditionally"
# assign its right-hand side -- i.e., to assign only if a value for the
# variable has not been externally set.
#
# By convention, external constants use uppercase words, separated by dashes.
# ==============================================================================

# ------------------------------------------------------------------------------
# Command output
# ------------------------------------------------------------------------------

COOKIECUTTER ?= $(shell which cookiecutter)

# ==============================================================================
# Internal Constants
#
# An internal constant is a variable that is intended to:
#
# 1. Have a fixed value;
# 2. Be set within a makefile (i.e., the "Makefile" itself or an "include"-ed
# ".mk" file).
#
# It is typically defined using the ":=" assignment operator to "simply" expand
# its right-hand side -- i.e., immediately evaluate any variables thererin,
# saving the resulting text as final the value.
#
# By convention, internal constants use uppercase words, separated by dashes.
# ==============================================================================

# ------------------------------------------------------------------------------
# Debugging & error capture
# ------------------------------------------------------------------------------

VARIABLES_TO_SHOW += COOKIECUTTER

# ------------------------------------------------------------------------------
# Help strings
# ------------------------------------------------------------------------------

MAKE_ARGS += [COOKIECUTTER=]

# ==============================================================================
# Internal Variables
#
# An internal variable is one that is intended to:
#
# 1. Have a value that depends on other variables, shell commands, etc. in its
#    definition;
# 2. Be set within a makefile (e.g., "Makefile") or an "include"-ed file).
#
# It is typically defined using the "=" assignment operator to "recursively"
# expand its right-hand side -- i.e., defer evaluation until the variable is
# used.
#
# By convention, internal variables are lowercase words, separated by
# underscores.
# ==============================================================================

# ------------------------------------------------------------------------------
# Sed commands
# ------------------------------------------------------------------------------

ifeq ($(COOKIECUTTER),)
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

ifeq ($(COOKIECUTTER),)
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
ifeq ($(COOKIECUTTER),)
define sed-cmd
	's/{{ cookiecutter.$1 }}/$2/g'
endef
endif

# ==============================================================================
# Directory Targets
# ==============================================================================

# Makes a directory tree.
ifeq ($(COOKIECUTTER),)
%/.: | $(LOG)
	@printf "Making directory tree $(dir_var)..."
	@mkdir -p $(@D) >$(LOG) 2>&1; \
	$(status_result)
endif

# ==============================================================================
# File Targets
# ==============================================================================

# Downloads a file.
# https://stackoverflow.com/questions/32672222/how-to-download-a-file-only-if-more-recently-changed-in-makefile
ifeq ($(COOKIECUTTER),)
%.download: | $(LOG) 
#	$(eval FILE = $(basename $@))
	@printf "Downloading file $(file_var)..."
	@curl -s -S -L -f $(FILE_URL)/$(file) -z $(file) -o $@ >$(LOG) 2>&1; \
	mv -n $@ $(file) >>$(LOG) 2>&1; \
	$(status_result)
endif

# Makes a special empty file for marking that a directory tree has been generated.
#ifneq ($(COOKIECUTTER),)
#%/.gitkeep:
#	@printf "Making directory tree for marker file $(target_var)..."
#	@printf "Making marker file $(target_var) and its directory tree..."
#	@mkdir -p $(@D); $(status_result)
#	@printf "Making marker file $(target_var)..."
#	@touch $@; $(status_result)
#endif

# ==============================================================================
# Second Expansion Targets
# ==============================================================================

.SECONDEXPANSION:
#$(PREFIX)/%.dummy: $$(@D)/.gitkeep | $$(@D)/. ## Make a directory tree.
