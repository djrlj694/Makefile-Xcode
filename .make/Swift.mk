# Swift.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: Swift.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.0.0
# CREATED: 03MAR2019
# REVISED: 12MAR2019
# ==============================================================================

# ==============================================================================
# Phony Targets
#
# A phony target is one that does not represent a file or directory. It can be
# thought of as an embedded shell script. It runs when an explicit request is
# made unless a file of the same name exists.
#
# Two reasons to use a phony target are:
#
# 1. To avoid a conflict with a file of the same name;
# 2. To improve performance.
# ==============================================================================

# ------------------------------------------------------------------------------
# Prerequisite phony targets for the "docs" target
# ------------------------------------------------------------------------------

.PHONY: docs-swift

## docs-swift: Generates Swift API documentation.
docs-swift: | $(LOG)
	@printf "Generating API documentation..."
	@jazzy \
		--min-acl internal \
		--no-hide-documentation-coverage \
		--theme fullwidth \
		--output ./docs \
        --documentation=./*.md \
		>$(LOG) 2>&1; \
	$(status_result)
	@rm -rf ./build
