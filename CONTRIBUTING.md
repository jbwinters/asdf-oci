# Contributing

## Setup

1. `git clone https://github.com/jbwinters/asdf-oci.git`
2. `asdf install`

## Structure

- `bin/*`: asdf plugin functions
- `lib/dependencies.txt`: list of dependencies required for this plugin to execute and install the tool as well as the tool's dependencies.
- `lib/helpers.bash`: helper functions that are plugin specific (not all reused yet)
- `lib/utils.bash`: utility functions that are asdf-plugin agnostic

## Testing Locally

### Manual

```shell
asdf plugin remove oci
asdf plugin add oci .
asdf install oci <version>
```

### asdf plugin tests

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]
asdf plugin test oci https://github.com/jbwinters/asdf-oci.git oci --version
```

Tests are automatically run in GitHub Actions on push and PR.
