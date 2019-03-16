# downloading.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: downloading.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0.0
# CREATED: 10MAR16MAR20192019
# REVISED: 16MAR2019
#
# NOTES:
#   For more info on terminology, style conventions, or source references, see
#   the file ".make/README.md".
# ==============================================================================

# ==============================================================================
# User-Defined Functions
# ==============================================================================

# $(call download-file,file,base-url)
# Downloads a file.
define download-file
	curl --silent --show-error --location --fail $2/$1 --time-cond $1
endef

# ==============================================================================
# File Targets
# ==============================================================================

# Downloads a file.
# https://stackoverflow.com/questions/32672222/how-to-download-a-file-only-if-more-recently-changed-in-makefile
%.download: | $(LOG) 
#	$(eval FILE = $(basename $@))
	@printf "Downloading file $(file_var)..."
#	@curl -s -S -L -f $(FILE_URL)/$(file) -z $(file) -o $@ >$(LOG) 2>&1; \

	@$(call download-file,$(file),$(FILE_URL)) -o $@ >$(LOG) 2>&1; \
	mv -n $@ $(file) >>$(LOG) 2>&1; \
	$(status_result)
