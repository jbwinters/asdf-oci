# asdf-oci

[![Test](https://github.com/jbwinters/asdf-oci/actions/workflows/test.yaml/badge.svg)](https://github.com/jbwinters/asdf-oci/actions/workflows/test.yaml)
[![Lint](https://github.com/jbwinters/asdf-oci/actions/workflows/lint.yaml/badge.svg)](https://github.com/jbwinters/asdf-oci/actions/workflows/lint.yaml)

[Oracle Cloud Infrastructure CLI](https://docs.oracle.com/en-us/iaas/tools/oci-cli/latest/oci_cli_docs/)
plugin for [asdf](https://asdf-vm.com). Install OCI CLI releases and pin the
`oci` version used by each project.

## Requirements

These instructions use asdf 0.16 or newer on Linux or macOS, with asdf's shims
on `PATH`.

- Python 3 with the `pip` and `venv` modules. The installer invokes `python3`,
  and the execution hook also requires a `python` command on `PATH`.
- Git, Bash, curl, jq, and the shell utilities listed in
  [lib/dependencies.txt](lib/dependencies.txt).
- Network access to GitHub for release discovery and to PyPI for downloads and
  build dependencies.
- A compiler and development headers when a Python dependency has no compatible
  wheel for your platform or Python version.

Python can be installed separately or managed with
[asdf-python](https://github.com/asdf-community/asdf-python). Check the Python
selected in your current directory before installing OCI:

```shell
python3 --version
python3 -m pip --version
python3 -m venv --help
python --version
```

## Install and select a version

Add this plugin and list the available OCI CLI releases:

```shell
asdf plugin add oci https://github.com/jbwinters/asdf-oci.git
asdf list all oci
```

Choose a numbered release. The examples below use `3.93.0`; replace it with the
version you want to install.

```shell
asdf install oci 3.93.0
asdf set -u oci 3.93.0
oci --version
```

`asdf set -u` writes your default version to `~/.tool-versions`. To pin OCI for
a project, run this from the project's directory and commit its
`.tool-versions`:

```shell
asdf set oci 3.93.0
```

A project's version takes precedence over your home-directory default. Inspect
the selected version and executable with:

```shell
asdf current oci
asdf which oci
```

See [asdf's version guide](https://asdf-vm.com/manage/versions.html) for version
selection. On asdf 0.16 and newer, `asdf set` replaces the old `asdf local` and
`asdf global` commands.

## Configure OCI access

Run OCI's configuration wizard after installation:

```shell
oci setup config
```

The wizard collects your tenancy, user, and region information and can generate
API keys. Follow Oracle's
[CLI configuration guide](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliconfigure.htm)
to finish configuring authentication. The default configuration file is
`~/.oci/config`.

## Update or uninstall

Update the plugin to obtain changes to its installation scripts:

```shell
asdf plugin update oci
```

To update the CLI itself, choose another numbered release from
`asdf list all oci`, then repeat the install and version-selection commands
above. Updating the plugin does not update an installed OCI CLI version.

Remove an installed version with:

```shell
asdf uninstall oci 3.93.0
```

The plugin leaves your OCI configuration and API keys in place when
uninstalling.

## How installation works

`bin/list-all` discovers releases from Oracle's
[OCI CLI repository](https://github.com/oracle/oci-cli). `bin/download` runs
`pip wheel` for the matching `oci-cli` package and its dependencies. This
downloads available wheels and builds source distributions while their build
dependencies can still be fetched.

`bin/install` creates an isolated virtual environment at
`${ASDF_INSTALL_PATH}/venv` and installs from those cached wheels without
accessing the package index. When invoked directly without a download cache, the
install script uses PyPI. The virtual environment is created at its final
location so its scripts retain valid interpreter paths. asdf exposes the `oci`
entry point through `${ASDF_INSTALL_PATH}/bin`.

The virtual environment uses the Python interpreter selected during
installation. Keep that interpreter available for as long as you use the
installed CLI version.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development tools, local installation
checks, and the repository layout. Report plugin installation or
version-selection problems in
[this repository's issues](https://github.com/jbwinters/asdf-oci/issues).

## License and origin

[MIT License](LICENSE). This plugin was originally forked from
[jthegedus/asdf-gcloud](https://github.com/jthegedus/asdf-gcloud), which was
created by James Hegedus. The original copyright notice and inherited release
history are retained in [LICENSE](LICENSE) and [CHANGELOG.md](CHANGELOG.md).
