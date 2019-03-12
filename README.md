# Makefile-xcode

`make` is a GNU utility for maintaining groups of programs.  In general, it is used to determine automatically which pieces of a large program need to be recompiled and issue commands by way of a set of user-named targets to recompile them.  This automation is facilitated via `Makefile` scripts.

The `Makefile` presented here is designed to handle common Xcode project activities via the `make` command.

## Usage

```sh
make [ -f MAKEFILE] [ OPTIONS ] ... [ TARGETS ] ...
```
### Options

`make` options include the following:

* `-f MAKEFILE`, `--file=MAKEFILE`, `--makefile=MAKEFILE`  
	* Use `MAKEFILE` as a makefile.
	* If this option is not specified, `make` looks in the current directory for the following named files:
		1. `makefile`
		2. `Makefile`

* `-n`, `--just-print`, `--dry-run`, `--recon`  
	* Print the commands that would be executed, but do not execute them.
	* This is a handy option for debugging makefiles. 

For all other options, refer to the [`make` man page](https://linux.die.net/man/1/make).

### Targets

#### Main Targets

The targets shown below represent main set of activities for managing an Xcode software project.

Target | Description
------ | -----------
`clean` | Removes files and directories.
`docs` | Makes API documentation.
`help` | Shows `make` usage documentation.
`setup` | Completes all Xcode project setup activities.
`test` | Completes all test activities.

#### Prerequisite Targets

For software project management activities that are more narrow in scope, prerequisite targets to the main targets can also be supplied to the `make` command.  Here are some of the higher level ones.

Target | Description
------ | -----------
`clean-carthage` | Completes all Carthage cleanup activities.
`clean-dirs` | Completes all directory cleanup activities.
`clean-git` | Completes all git cleanup activities.
`clean-md` | Completes all Markdown cleanup activities.
`setup-carthage` | Completes all Carthage setup activities.
`setup-cocoapods` | Completes all CocoaPods setup activities.
`setup-dirs` | Completes all directory setup activities.
`setup-git` | Completes all git setup activities.
`setup-md` | Makes all Markdown files.
`test-log` | Shows the most recently generated log for a specified release.
`test-vars-all` | Shows all Makefile variables (i.e., built-in and custom).
`test-vars-some` | Shows only a few custom Makefile variables.

## Requirements

Makefile-xcode requires the following to be installed on your system:

* `git` (Apple Git-113 -- git 2.17.2 -- or later)
* `make` (GNU Make 3.81 or later)

## Installation

1. Clone or download the `Makefile-xcode` repository.
2. Copy the `Makefile` file to the root folder of your project.

## Known issues

Currently, there are no known issues.  If you discover any, please kindly submit a [pull request](CONTRIBUTING.md).

## Contributing

Code and codeless (e.g., documentation) contributions toward improving Makefile-xcode are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md) for more information on how to become a contributor.

## License

Makefile-xcode is released under the [MIT License](LICENSE.md).

## References

See [REFERENCES.md](REFERENCES.md) for a list of sources that I found helpful or inspirational when learning new topics, troubleshooting bugs, authoring documentation, etc.