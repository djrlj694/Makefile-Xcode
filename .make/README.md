# README

The following is a summary of the [files](#files), style [conventions](#conventions), and [terminology](#terminology) used in this makefile project.

# Files

The files in the `.make` directory are intended for general reusability and maintainability. They are organized based on considerations such as feature additions and development platform extensions.

File | Description
---- | -----------
common.mk | TBD
debugging.mk | TBD
formatting.mk | TBD
helping.mk | TBD
setting_up.mk  | TBD

File | Description
---- | -----------
Carthage.mk | TBD
CocoaPods.mk | TBD
cookiecutter.mk | TBD
git.mk  | TBD
GitHub.mk | TBD
sed.mk | TBD
Swift.mk | TBD
Xcode.mk | TBD

# Conventions

This project distinguishes makefile variables into 5 categories, based on considerations such as how the variable is assigned or defined as well its intended usage (i.e., how values are set and where).  For each variable category, there is a convention for naming and defining a variable. For more information about these variable categories, please refer to the [glossary](GLOSSARY.md) of terms or click on a particular variable category in the table below.

| Variable Category | Naming Convention | Example | Definition Expansion |
| ----------------- | ----------------- | ------- | -------------------- |
| [External constant](#external-constants) | Uppercase, underscore-separated words | `USER ?= $(shell whoami)` | Deferred |
| [Internal constant](#internal-constants) | Uppercase, underscore-separated words | `MKDIR := mkdir -p` | Immediate |
| [Internal variable](#internal-variables) | Lowercase, underscore-separated words | `subdir = $(shell basename $(@D))` | Deferred |
| [Macro](#macros) | Lowercase, dash-separated words | <code>define usage_help<br/><br/>Usage:<br/>&nbsp;&nbsp;make = make $(TARGET_ARG) $(MAKE_ARGS)<br/>endef</code> | Deferred |
| [User-defined function](#user-defined-functions) | Lowercase, dash-separated words | <code>define result<br/>&nbsp;&nbsp;([ $$? -eq 0 ] && printf "$1") \|\| <br/>&nbsp;&nbsp;(printf "$(FAILED)\n" && cat $(LOG) && echo)<br/>endef</code> | Deferred |

# Glossary

This section list technical terminology used in in this makefile project. Some of the terms are generally accepted as part of makefile parlance. Others are unique to this particular makefile project, in part to better facilitate common conventions for, say, naming and defining makefile variables.

## Variables

This project distinguishes makefile variables into the following 5 categories, based on considerations such as how the variable is assigned or defined as well its intended usage (i.e., how values are set and where).

### External Constants

An external constant is a variable that is intended to:

1. Have a fixed value;
2. Be set at the command line or by the environment.

It is typically defined using the `?=` assignment operator to "conditionally" assign its right-hand side -- i.e., to assign only if a value for the variable has not been externally set.

By convention, external constants use uppercase, dash-separated words for names.

### Internal Constants

An internal constant is a variable that is intended to:

1. Have a fixed value;
2. Be set within a makefile (e.g., `Makefile`) or an `include`-ed file.

It is typically defined using the `:=` assignment operator to "simply" expand its right-hand side -- i.e., immediately evaluate any variables therein, saving the resulting text as final the value.

By convention, internal constants uses uppercase, dash-separated words for names.

### Internal Variables

An internal variable is one that is intended to:

1. Have a value that depends on other variables, shell commands, etc. in its definition;
2. Be set within a makefile (e.g., `Makefile`) or an `include`-ed file.

It is typically defined using the `=` assignment operator to "recursively" expand its right-hand side -- i.e., defer evaluation until the variable is used.

By convention, internal variables use lowercase, underscore-separated words for names.

### Macros

A macro is a variable that is defined using the "define" directive instead of an assignment operator. It is typically used to define a multi-line variable.

By convention, macros use lowercase, underscore-separated words for names.

### User-Defined Variables

A user-defined function is a variable or macro that includes one or more temporary variables (`$1`, `$2`, etc.) in its definition.

By convention, its user-defined functions use lowercase, dash-separated words for names.

## Targets

### Phony Targets

A phony target is one that does not represent a file or directory. It can be thought of as an embedded shell script. It is run when an explicit request is made unless unless a file of the same name exists.

Two reasons to use a phony target are:

1. To avoid a conflict with a file of the same name;
2. To improve performance.

### Intermediate Targets

An intermediate target corresponds to a file that is needed on the way from a source file to a target file.  It typically is a temporary file that is needed only once to generate the target after the source changed.  The `make` command automatically removes files that are identified as intermediate targets.  In other words, such files that did not exist before a `make` run executed do not  exist after a `make` run.

### Second Expansion Targets

# References

1. https://www.cl.cam.ac.uk/teaching/0910/UnixTools/make.pdf
2. https://www.gnu.org/software/make/manual/make.html
3. https://www.oreilly.com/library/view/managing-projects-with/0596006101/
4. https://www.oreilly.com/openbook/make3/book/
5. https://en.wikipedia.org/wiki/Make_(software)
