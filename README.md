<div align="center">

# asdf-oci ![Test](https://github.com/jbwinters/asdf-oci/workflows/Test/badge.svg) ![Lint](https://github.com/jbwinters/asdf-oci/workflows/Lint/badge.svg)


[OCI CLI](https://docs.oracle.com/en-us/iaas/tools/oci-cli/latest/oci_cli_docs/) plugin for [asdf version manager](https://asdf-vm.com) allowing you to pin `oci` versions for each project.

![asdf-oci](./assets/asdf-oci.png)

</div>

# Dependencies

Are tracked in [lib/dependencies.txt](lib/dependencies.txt) and checked on installation of the plugin and `asdf install oci *`. Core dependencies include `bash`, `curl`, `jq`, `python3`, `sort`, and `tar`.

# Install

Plugin:

```shell
asdf plugin add oci https://github.com/jbwinters/asdf-oci
```

OCI:

```shell
asdf install oci latest
```

Set global version:

```shell
asdf global oci latest
```

These commands also apply to `asdf local oci <version>`.

## How it works

`asdf-oci` provisions an isolated Python virtual environment per version and installs `oci-cli==<version>` with `pip`. `asdf install` first runs the plugin's `bin/download` script, which caches the PyPI wheels for the requested release and its dependencies so that `bin/install` can complete without additional network calls. The resulting `oci` entry point is shimmed via `${ASDF_INSTALL_PATH}/bin`.

### Oracle release parity

Oracle distributes the CLI through the same PyPI artifacts that back the unattended `install.sh` script (Quickstart, updated October 2025). The plugin tracks those tagged releases so that Linux, macOS, and Windows developers receive the identical CLI bits that Oracle publishes, while still benefiting from per-project version pinning and shims.

### Verify the install

After `asdf install`, confirm the version matches expectations:

```shell
asdf exec oci --version
```

### First-time configuration

Run the guided setup when you need a profile:

```shell
asdf exec oci setup config
```

The wizard prompts for tenancy OCID, user OCID, region, and creates API keys. Configuration is stored at `~/.oci/config` by default and is not removed when uninstalling a tool version.

# Why?

The asdf config file, `.tool-versions`, allows pinning each tool in your project to a specific version. This ensures that ALL developers are using the same version of each tool. Same `python`, same `oci`, same `terraform` etc.

When you update a version in `.tool-versions`, `asdf` will prompt all users who do not have the correct versions to upgrade. This enables whole teams to update their tools in unison.

# Contributing

Contributions of any kind welcome! See the [contributing guide](CONTRIBUTING.md).

[Thanks goes to these contributors](https://github.com/jbwinters/asdf-oci/graphs/contributors)!

## Why are there Node deps here?

I decided the value of [commitlint](https://commitlint.js.org/#/) & sharing Git Hooks with [husky](https://typicode.github.io/husky/#/) were greater than the cost of including these deps. Not only this, but dogfooding `asdf` for dev deps makes this less of an issue.

# License

MIT License

Fork of https://github.com/jthegedus/asdf-gcloud:
[MIT License](LICENSE) © [James Hegedus](https://github.com/jthegedus/)
