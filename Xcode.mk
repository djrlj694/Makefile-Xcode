# Xcode.mk
# Copyright © 2019 Synthelytics LLC. All rights reserved.
#
# ==============================================================================
# PROGRAM: Xcode.mk
# AUTHORS: Robert L. Jones
# COMPANY: Synthelytics LLC
# VERSION: 1.1.0
# CREATED: 04FEB2019
# REVISED: 23FEB2019
# ==============================================================================

# ==============================================================================
# Variables
# ==============================================================================

# Directories

RESOURCES = Data Fonts Localization Media UserInterfaces
RESOURCES_DIRS = $(addprefix $(PROJECT)/Resources/,$(addsuffix /.,$(RESOURCES)))

SOURCES = Controllers Extensions Models Protocols ViewModels Views
SOURCES_DIRS = $(addprefix $(PROJECT)/Sources/,$(addsuffix /.,$(SOURCES)))
