# sed.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: sed.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0.0
# CREATED: 16MAR2019
# REVISED: 200MAR2019
#
# NOTES:
#   For more info on terminology, style conventions, or source references, see
#   the file ".make/README.md".
# ==============================================================================

# ==============================================================================
# Macros
# ==============================================================================

# Run a sed script ("$<") to perform text transformations on a file ("$@"), such
# as substituting regular exprression pattern matches with replacement values.
define update-file
	@sed -f $< $@ > $@.tmp
	@mv $@.tmp $@
endef

# ==============================================================================
# User-Defined Functions
# ==============================================================================

# $(call add-sed-cmd,cmd)
# Adds a sed command to a sed script.
add-sed-cmd = echo $1 >> $@

# $(call add-sed-cmds,add_sed_cmd,vars)
# Generates a list of syntactically identical sed command to add to the same
# sed script.
add-sed-cmds = $(foreach var,$2,$(call $1,$(var)))
