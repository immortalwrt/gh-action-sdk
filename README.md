# ImmortalWrt GitHub Action SDK

GitHub CI action to build packages via SDK using official ImmortalWrt SDK Docker
containers. This is primary used to test build ImmortalWrt repositories but can
also be used for downstream projects maintaining their own package
repositories.

This is a fork of [openwrt/gh-action-sdk](https://github.com/openwrt/gh-action-sdk).

## Example usage

The following YAML code can be used to build all packages of a repository and
store created `ipk` files as artifacts.

```yaml
name: Test Build

on:
  pull_request:
    branches:
      - master

jobs:
  build:
    name: ${{ matrix.arch }} build
    runs-on: ubuntu-latest
    strategy:
      matrix:
        arch:
          - sdk-x86_64
          - sdk-bcm27xx_bcm2710

    steps:
      - uses: actions/checkout@v2
        with:
          fetch-depth: 0

      - name: Build
        uses: immortalwrt/gh-action-sdk@master
        env:
          ARCH: ${{ matrix.arch }}

      - name: Store packages
        uses: actions/upload-artifact@v2
        with:
          name: ${{ matrix.arch}}-packages
          path: bin/packages/${{ matrix.arch }}/packages/*.ipk
```

## Environmental variables

The action reads a few env variables:

* `ARCH` determines the used ImmortalWrt SDK Docker container.
* `BUILD_LOG` stores build logs in `./logs`.
* `CONTAINER` can set other SDK containers than `immortalwrt/opde`.
* `EXTRA_FEEDS` are added to the `feeds.conf`, where `|` are replaced by white
  spaces.
* `FEEDNAME` used in the created `feeds.conf` for the current repo. Defaults to
  `action`.
* `IGNORE_ERRORS` can ignore failing packages builds.
* `KEY_BUILD` can be a private Signify/`usign` key to sign the packages feed.
* `NO_DEFAULT_FEEDS` disable adding the default SDK feeds
* `NO_REFRESH_CHECK` disable check if patches need a refresh.
* `NO_SHFMT_CHECK` disable check if init files are formated
* `V` changes the build verbosity level.
