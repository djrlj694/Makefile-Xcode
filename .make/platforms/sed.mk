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

# $(call add-sed-cmd,template-var,replacement)
# Generates a sed command for replacing Cookiecutter template variables with
# appropriate values.
define add-sed-cmd
	echo 's/{{ cookiecutter.$1 }}/$2/g' >> $@
endef

# $(call sed-cmd,template-var,replacement)
# Generates a sed command for replacing Cookiecutter template variables with
# appropriate values.
define sed-cmd
	's/{{ cookiecutter.$1 }}/$2/g'
endef