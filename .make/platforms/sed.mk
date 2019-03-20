# sed.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: sed.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0.0
# CREATED: 16MAR2019
# REVISED: 20MAR2019
#
# NOTES:
#   For more info on terminology, style conventions, or source references, see
#   the file ".make/README.md".
# ==============================================================================

# ==============================================================================
# Macros
# ==============================================================================

# Run a sed script ("$<") to perform text transformations on a file ("$@"), such
# as substituting regular expression pattern matches with replacement values.
define update-file
	@sed -f $< $@ > $@.tmp
	@mv $@.tmp $@
endef

# ==============================================================================
# User-Defined Functions
# ==============================================================================

# $(call add-sed-cmds,sed-cmd,kv_var)
# Generates and adds a sed command to a sed script from a single key/value pair.
define add-sed-cmd
	$(eval key = $(shell echo '$2' | cut -d':' -f1))
	$(eval value = $(shell echo '$2' | cut -d':' -f2))
	@echo $(call $1,$(key),$(value)) >> $@
endef

# $(call add-sed-cmds,sed-cmd,kv_list)
# Generates and adds a list of syntactically identical sed commands to the same
# sed script from a list of key/value.
add-sed-cmds = $(foreach kv_var,$2,$(call add-sed-cmd,$1,$(kv_var)))
