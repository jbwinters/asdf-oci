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

`asdf-oci` executes Oracle's official unattended installer (`install.sh`) with `--oci-cli-version <version>` so every `asdf install` matches the requested release. The CLI is installed into an internal virtual environment under the plugin's install directory, while the `oci` executable is shimmed via `asdf`.

### Official Quickstart parity

Oracle documents multiple installation paths (Quickstart, updated October 2025). The key commands are:

- **Oracle Linux 9** – `sudo dnf -y install oraclelinux-developer-release-el9` then `sudo dnf install python39-oci-cli`
- **Oracle Linux 8** – `sudo dnf -y install oraclelinux-developer-release-el8` then `sudo dnf install python36-oci-cli`
- **Oracle Linux 7** – `sudo yum install python36-oci-cli`
- **macOS** – `brew update && brew install oci-cli`
- **Windows** – install via the MSI or run the provided PowerShell script from GitHub
- **Linux & UNIX** – `bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"`

This plugin wraps the Linux & UNIX installer path so that `asdf` users stay aligned with Oracle's current automation while still benefiting from per-project version pinning and shims.

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
