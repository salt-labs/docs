---
title: "kctrl"
date: 2024-01:01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "The kapp-controller CLI utility"
type: "docs"
weight: 3602
draft: false
---

## Directory Structure

To manage multiple packages, we need to create a directory structure to organise the files.

- Setup the directory structure.

{{< tabs >}}

{{< tab "Linux" >}}

```bash
# Create the parent folders for packages and repositories.
mkdir --parents "${CARVEL_PACKAGE_HOME}/"{packages,repos}

# Create the package folder
mkdir --parents "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}"

# Create the repo folder
mkdir --parents "${CARVEL_PACKAGE_HOME}/repos/${CARVEL_PACKAGE_REPO}"

# OPTIONAL: These last folders are option opinionated steps.

#   Optional: Create a location to store upstream vendor artifacts pulled with vendir
mkdir --parents "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}"/vendor

#   Optional: Create a separate location to store the imgpkg bundle and associated items.
#       vendor = X
#
mkdir --parents "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}"/bundle/{ytt,vendor}

#   Optional: Create a location where Package Consumers can look for examples
mkdir --parents "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}"/examples

#   Optional: Create the folder where we will store lock files for imgpkg bundles.
mkdir --parents "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}"/.imgpkg

#   Optional: Create the folder where tests for the package are located
mkdir --parents "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}"/tests

```

{{< /tab >}}

{{< tab "macOS" >}}

**TODO:** Put commands here for macOS

{{< /tab >}}

{{< tab "Windows" >}}

**TODO:** Put commands here for Windows

{{< /tab >}}

{{< /tabs >}}

## Namespace

- In your development cluster, create a namespace where we will manage Carvel packages from and set the kubectl context.

{{< tabs >}}

{{< tab "Cross Platform" >}}

```bash
kubectl create ns kapps

kubectl config set-context --current --namespace kapps
```

{{< /tab >}}

{{< /tabs >}}

## Package

### Init

- Now it's time to use the `kctrl` tool to initialize the package using the interactive wizard.

{{< tabs >}}

{{< tab "Cross Platform" >}}

```bash
kctrl --debug \
    package init \
        --chdir "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}"

# Once you have completed the wizard, take a look at the folder structure.
tree "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}"

# Now edit the files as required for your package.
```

{{< /tab >}}

{{< /tabs >}}

### Develop

This is where we use `kctrl` to assist with the inner development loop of testing the package locally before release.

{{< tabs >}}

{{< tab "Linux" >}}

```bash
kctrl --debug \
    dev \
        --delete \
        --local \
        --namespace "${CARVEL_PACKAGE_NAMESPACE}" \
        --kbld-build \
        --file "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}/package-resources.yml"
```

{{< /tab >}}

{{< tab "macOS" >}}

**TODO:** Put commands here for macOS

{{< /tab >}}

{{< tab "Windows" >}}

**TODO:** Put commands here for Windows

{{< /tab >}}

{{< /tabs >}}

### Release

#### Release the Package

- Once you are ready to release the package, you can generate the `Package` and `PackageMetadata` CRDs using `release`.

{{< tabs >}}

{{< tab "Cross Platform" >}}

```bash
kctrl --debug \
    package release \
        --chdir "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}" \
        --openapi-schema=true \
        --build-ytt-validations=true \
        --copy-to "${CARVEL_PACKAGE_HOME}" \
        --repo-output "${CARVEL_PACKAGE_HOME}/repos/${CARVEL_PACKAGE_REPO}" \
        --tag "build-$(date +%Y-%m-%d).$((COUNT++))" \
        --version "${CARVEL_PACKAGE_VERSION}"
```

{{< /tab >}}

{{< /tabs >}}

#### Release the a Repository

- Publish the Package Repository using the previously build `Package` and `PackageMetadata`.

{{< tabs >}}

{{< tab "Linux" >}}

```bash
kctrl package repository release \
    --chdir "${CARVEL_PACKAGE_HOME}/repos/${CARVEL_PACKAGE_REPO}" \
    --version "$(date +%Y-%m-%d)"
```

{{< /tab >}}

{{< tab "macOS" >}}

**TODO:** Put commands here for macOS

{{< /tab >}}

{{< tab "Windows" >}}

**TODO:** Put commands here for Windows

{{< /tab >}}

{{< /tabs >}}

### Test

So far we have;

- [x] Developed the Package
- [x] Tested the Package Locally
- [x] Released the Package to the Registry
- [x] Updated the Package in the Package Repository

The final test is to test the package from the Package Repository.

{{< tabs >}}

{{< tab "Linux" >}}

```bash
kctrl dev \
    --delete \
    --file "${}" \
    --namespace "${CARVEL_PACKAGE_NAMESPACE}"
```

{{< /tab >}}

{{< tab "macOS" >}}

**TODO:** Put commands here for macOS

{{< /tab >}}

{{< tab "Windows" >}}

**TODO:** Put commands here for Windows

{{< /tab >}}

{{< /tabs >}}

- Create the samples used by `Package Consumers`.

Now the package is ready for consumption by `Package Consumers`.
