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

# $(call add-sed-cmd,cmd)
# Generates a sed command for substituting the replacement string for the 1st
# instance of the regular expression in the pattern space.
add-sed-cmd = echo '$1' >> $@

# $(call add-sed-cmds,add_sed_cmd,vars)
# Generates a sed command for replacing Cookiecutter template variables with
# appropriate values.
# Generates sed commands for substituting the replacement string for the 1st
# instance of the Cookiecutter template variable in the pattern space.
# $(call add-sed-cmds,template-vars)
# Generates a sed command for replacing Cookiecutter template variables with
# appropriate values.
# Generates sed commands for substituting the replacement string for the 1st
# instance of the Cookiecutter template variable in the pattern space.
add-sed-cmds = $(foreach var,$2,$(call $1,$(var)))

# $(call sed-cmd,template-var,replacement)
# Generates a sed command for replacing Cookiecutter template variables with
# appropriate values.
#define sed-cmd
#'s/{{ cookiecutter.$1 }}/$2/g'
#endef
sed-cmd = 's/$1/$2/g'
