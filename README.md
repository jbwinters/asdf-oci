# DANGER: This is a work in progress and does not work as-is, feel free to contribute. 
This is a fork of asdf-gcloud and should be simple to translate.

<div align="center">

# asdf-oci ![Test](https://github.com/jbwinters/asdf-oci/workflows/Test/badge.svg) ![Lint](https://github.com/jbwinters/asdf-oci/workflows/Lint/badge.svg)

<a href="https://docs.oracle.com/en-us/iaas/tools/oci-cli/3.20.3/oci_cli_docs/" target="_blank" rel="noopener noreferrer">
  <img src="assets/logo_lockup_cloud_rgb.png" height="42" align="middle" />
</a>

[OCI CLI](https://docs.oracle.com/en-us/iaas/tools/oci-cli/3.20.3/oci_cli_docs/) plugin for [asdf version manager](https://asdf-vm.com) allowing you to pin `oci` versions for each GCP project.

![asdf-oci](./assets/asdf-oci.png)

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Default Cloud SDK Components](#default-cloud-sdk-components)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

Are tracked in [lib/dependencies.txt](lib/dependencies.txt) and checked on installation of plugin and `asdf install oci *`. The core dependencies are: `bash`, `curl`, `python`, `sort`, `tar`.

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

# Why?

The asdf config file, `.tool-versions`, allows pinning each tool in your project to a specific version. This ensures that ALL developers are using the same version of each tool. Same `python`, same `oci`, same `terraform` etc.

When you update a version in `.tool-versions`, `asdf` will prompt all users who do not have the correct versions to upgrade. This enables whole teams to update their tools in unison.

# FAQ

# Contributing

Contributions of any kind welcome! See the [contributing guide](CONTRIBUTING.md).

[Thanks goes to these contributors](https://github.com/jbwinters/asdf-oci/graphs/contributors)!

## Why are there Node deps here?

I decided the value of [commitlint](https://commitlint.js.org/#/) & sharing Git Hooks with [husky](https://typicode.github.io/husky/#/) were greater than the cost of including these deps. Not only this, but dogfooding `asdf` for dev deps makes this less of an issue.

# License

MIT License

Fork of https://github.com/jthegedus/asdf-gcloud:
[MIT License](LICENSE) © [James Hegedus](https://github.com/jthegedus/)
