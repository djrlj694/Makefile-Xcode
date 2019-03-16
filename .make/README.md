# README

The files in the `.make` directory are intended for general reusability and maintainability. They are organized based on considerations such as feature additions and development platform extensions.

# Files

File | Description
---- | -----------
Carthage.mk | TBD
CocoaPods.mk | TBD
common.mk | TBD
cookiecutter.mk | TBD
git.mk  | TBD
GitHub.mk | TBD
main.mk | TBD
Swift.mk | TBD
Xcode.mk | TBD

# Conventions

This project distinguishes makefile variables into 5 categories, based on considerations such as how the variable is assigned or defined as well its intended usage (i.e., how values are set and where).  For each variable category, there is a convention for naming and defining a variable. For more information about these variable categories, please refer to the [glossary](GLOSSARY.md) of terms or click on a particular variable category in the table below.

| Variable Category | Naming Convention | Example | Definition Expansion |
| ----------------- | ----------------- | ------- | -------------------- |
| [External constant](GLOSSARY.md#external-constants) | Uppercase, underscore-separated words | `USER ?= $(shell whoami)` | Deferred |
| [Internal constant](GLOSSARY.md#internal-constants) | Uppercase, underscore-separated words | `MKDIR := mkdir -p` | Immediate |
| [Internal variable](GLOSSARY.md#internal-variables) | Lowercase, underscore-separated words | `subdir = $(shell basename $(@D))` | Deferred |
| [Macro](GLOSSARY.md#macros) | Lowercase, dash-separated words | `define usage_help<br/><br/>Usage:<br/>&nbsp;&nbsp;make = make $(TARGET_ARG) $(MAKE_ARGS)<br/>endef` | Deferred |
| [User-defined function](GLOSSARY.md#user-defined-functions) | Lowercase, dash-separated words | ```define result<br/>&nbsp;&nbsp;([ $$? -eq 0 ] && printf "$1") \|\| \ <br/>&nbsp;&nbsp;(printf "$(FAILED)\n" && cat $(LOG) && echo)<br/>endef``` | Deferred |

# References

1. https://www.cl.cam.ac.uk/teaching/0910/UnixTools/make.pdf
2. https://www.gnu.org/software/make/manual/make.html
3. https://www.oreilly.com/library/view/managing-projects-with/0596006101/
4. https://www.oreilly.com/openbook/make3/book/
5. https://en.wikipedia.org/wiki/Make_(software)
