# README: `.make`

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

# Glossary

## Variables

### External Constants

An external constant is a variable that is intended to:

1. Have a fixed value;
2. Be set at the command line or by the environment.

It is typically defined using the "?=" assignment operator to "conditionally" assign its right-hand side -- i.e., to assign only if a value for the variable has not been externally set.

By convention, external constants use uppercase, dash-separated words for names.

### Internal Constants

An internal constant is a variable that is intended to:

1. Have a fixed value;
2. Be set within a makefile (e.g., "Makefile") or an "include"-ed file.

It is typically defined using the ":=" assignment operator to "simply" expand its right-hand side -- i.e., immediately evaluate any variables therein, saving the resulting text as final the value.

By convention, internal constants uses uppercase, dash-separated words for names.

### Internal Variables

An internal variable is one that is intended to:

1. Have a value that depends on other variables, shell commands, etc. in its definition;
2. Be set within a makefile (e.g., "Makefile") or an "include"-ed file.

It is typically defined using the "=" assignment operator to "recursively" expand its right-hand side -- i.e., defer evaluation until the variable is used.

By convention, internal variables use lowercase, underscore-separated words for names.

### Macros

A macro is a variable that is defined using the "define" directive instead of an assignment operator. It is typically used to define a multi-line variable.

By convention, macros use lowercase, underscore-separated words for names.

### User-Defined Variables

A user-defined function is a variable or macro that includes one or more temporary variables ($1, $2, etc.) in its definition.

By convention, its user-defined functions use lowercase, dash-separated words for names.

## Targets

### Phony Targets

A phony target is one that does not represent a file or directory. It can be thought of as an embedded shell script. It is run when an explicit request is made unless unless a file of the same name exists.

Two reasons to use a phony target are:

1. To avoid a conflict with a file of the same name;
2. To improve performance.

# References

1. https://www.gnu.org/software/make/manual/html_node/Call-Function.html
2. https://www.oreilly.com/openbook/make3/book/ch11.pdf
3. https://www.oreilly.com/openbook/make3/book/ch04.pdf
