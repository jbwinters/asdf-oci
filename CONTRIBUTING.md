# Contributing

## Setup

Clone the repository and enter the checkout:

```shell
git clone https://github.com/jbwinters/asdf-oci.git
cd asdf-oci
```

Install the runtime requirements listed in [README.md](README.md#requirements).
For development, also install ShellCheck, shfmt, and Deno; the versions used by
this repository are pinned in [.tool-versions](.tool-versions). If you manage
those tools with asdf, add their plugins before running `asdf install`.

## Repository layout

- `bin/list-all`: discovers OCI CLI release versions from GitHub.
- `bin/download`: downloads or builds the wheels needed for a release.
- `bin/install`: creates the virtual environment and installs the cached wheels.
- `bin/exec-env`: checks the Python command when asdf runs OCI.
- `bin/uninstall`: removes a CLI installation while retaining OCI configuration.
- `lib/dependencies.txt`: shell commands checked by the installer.
- `lib/utils.bash`: shared logging, dependency checks, and version-sorting
  helpers.
- `scripts/`: ShellCheck and shfmt entry points.
- `.github/workflows/`: lint, formatting, plugin smoke tests, and release
  automation.

## Lint and format

Run the same shell checks used by CI:

```shell
bash scripts/shellcheck.bash
bash scripts/shfmt.bash
```

Apply shell formatting with `bash scripts/format.bash`. Format changed Markdown
files with Deno, for example:

```shell
deno fmt README.md CONTRIBUTING.md CHANGELOG.md
deno fmt --check README.md CONTRIBUTING.md CHANGELOG.md
```

## Test the working tree

Run the following in Bash from the repository root. It exercises the current
checkout's download and install callbacks in a temporary directory, including an
installation with the package index disabled. Replace `3.93.0` with another OCI
CLI release as needed.

```bash
(
  set -euo pipefail
  oci_test_dir=$(mktemp -d)
  trap 'rm -rf "$oci_test_dir"' EXIT

  export ASDF_INSTALL_TYPE=version
  export ASDF_INSTALL_VERSION=3.93.0
  export ASDF_DOWNLOAD_PATH="$oci_test_dir/download"
  export ASDF_INSTALL_PATH="$oci_test_dir/install"

  bash bin/download
  PIP_NO_INDEX=1 bash bin/install
  "$ASDF_INSTALL_PATH/bin/oci" --version
  "$ASDF_INSTALL_PATH/venv/bin/pip" check
)
```

This check uses your selected Python and leaves your normal asdf installation
and version selections intact. It tests the plugin callbacks directly; the
[CI plugin test](.github/workflows/test.yaml) also checks `oci --version`
through asdf on Ubuntu and macOS.

For changes to dependency caching, force a source build by replacing the
download line with `PIP_NO_BINARY=pyyaml PIP_NO_CACHE_DIR=1 bash bin/download`.
The later installation must still succeed with `PIP_NO_INDEX=1`. Also check that
a failed installation removes the incomplete install directory.

## Pull requests

Describe the problem, the resulting behavior, and the checks you ran. Include
the Python, asdf, and OCI CLI versions when reporting an installation issue. Use
a Conventional Commit style title such as
`fix: preserve virtualenv interpreter paths` or
`docs: update OCI setup instructions`.
