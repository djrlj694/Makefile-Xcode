# sed.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: sed.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0.0
# CREATED: 16MAR2019
# REVISED: 16MAR2019
#
# NOTES:
#   For more info on terminology, style conventions, or source references, see
#   the file ".make/README.md".
# ==============================================================================

# ==============================================================================
# Macros
# ==============================================================================

define update-file
	@sed -f $< $@ > $@.tmp
	@mv $@.tmp $@
endef

# ==============================================================================
# User-Defined Functions
# ==============================================================================

# $(call add-sed-cmd,regexp,replacement)
# Generates a sed command for substituting the replacement string for the 1st
# instance of the regular expression in the pattern space.
add-sed-cmd = echo 's/$1/$2/g' >> $@

# $(call sed-cmd,template-var,replacement)
# Generates a sed command for replacing Cookiecutter template variables with
# appropriate values.
#define sed-cmd
#'s/{{ cookiecutter.$1 }}/$2/g'
#endef
sed-cmd = 's/$1/$2/g'
