# formatting.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: formatting.mk
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
# Internal Constants
# ==============================================================================

# ------------------------------------------------------------------------------
# Special characters
# ------------------------------------------------------------------------------

EMPTY :=
SPACE := $(EMPTY) $(EMPTY)

# ------------------------------------------------------------------------------
# ANSI escape sequences
#
# NOTE: "\033" is a C-style octal code representing an ASCI escape character.
# ------------------------------------------------------------------------------

# Setting the text intensity/emphasis of STDOUT.
RESET := \033[0m
BOLD := \033[1m
DIM := \033[2m

# Setting the text color of STDOUT.
FG_CYAN := \033[0;36m
FG_GREEN := \033[0;32m
FG_RED := \033[0;31m
FG_YELLOW := \033[1;33m
