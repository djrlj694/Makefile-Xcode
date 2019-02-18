# Makefile-xcode

`make` is a GNU utility for maintaining groups of programs.  In general, it is used to determine automatically which pieces of a large program need to be recompiled and issue commands by way of a set of user-named targets to recompile them.  This automation is facilitated via `Makefile` scripts.

The `Makefile` presented here is designed to handle common Xcode project activities via the `make` command.

## Usage

```bash
make [ -f MAKEFILE] [ OPTIONS ] ... [ TARGETS ] ...
```
### Options

`make` options discussed in class include the following:

* `-f MAKEFILE`, `--file=MAKEFILE`, `--makefile=MAKEFILE`  
	* Use `MAKEFILE` as a makefile.
	* If this option is not specified, `make` looks in the current directory for the following named files:
		1. `makefile`
		2. `Makefile`

* `-n`, `--just-print`, `--dry-run`, `--recon`  
	* Print the commands that would be executed, but do not execute them.
	* This is a handy option for debugging makefiles. 

For all other options, refer to the manpage (`man make`).

## Installation

1. Clone or download the `${PROJECT}` repository.
2. Copy the `Makefile` file to the root folder of your project.

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## Known issues

Currently, there are no known issues.  If you discover any, please kindly submit a [pull request](CONTRIBUTING.md).

## License

${PROJECT} is released under the [MIT License](LICENSE.md).
