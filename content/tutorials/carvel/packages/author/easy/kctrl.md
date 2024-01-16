---
title: "kctrl"
date: 2024-01:01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "The kapp-controller CLI utility"
type: "docs"
weight: 3603
draft: false
---

## Overview

`kctrl` is a CLI for working with the `kapp-controller`. One of the tasks that `kctrl` can perform is to make the process of creating carvel packages easier.

The following steps continue on from the preparation page and develop an example package and repository.

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

# OPTIONAL: These last folders are optional and opinionated steps to layout the structure in a particular way.

#   Optional: Create a directory where all package configuration and ytt will live.
mkdir --parents "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}"/config/ytt

#   Optional: Create a location where Package Consumers can look for examples
mkdir --parents "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}"/examples

#   Optional: Create the folder where we will store lock files for imgpkg bundles.
mkdir --parents "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}"/.imgpkg

#   Optional: Create the folder where tests for the package are located
mkdir --parents "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}"/tests
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

## Namespace

- In your development cluster, create a namespace and SA where we will manage Carvel packages from and set the kubectl context.

{{< tabs >}}

{{< tab "Linux" >}}

```bash
# Create the namespace
kubectl create ns ${CARVEL_PACKAGE_NAMESPACE}

# Create a SA inside the namespace
kubectl create sa -n ${CARVEL_PACKAGE_NAMESPACE} ${CARVEL_PACKAGE_SA}

# As this is just for local development, YOLO create a loose ClusterRole
kubectl create clusterrole \
    "${CARVEL_PACKAGE_NAMESPACE}-kapp-controller" \
    --resource='*.*' \
    --non-resource-url='*' \
    --verb='*'

# Create a ClusterRoleBinding for the new SA
kubectl create clusterrolebinding \
    "${CARVEL_PACKAGE_NAMESPACE}-kapp-controller" \
    --serviceaccount "${CARVEL_PACKAGE_NAMESPACE}:${CARVEL_PACKAGE_SA}" \
    --clusterrole "${CARVEL_PACKAGE_NAMESPACE}-kapp-controller"

# Set your working context into the correct namespace.
kubectl config set-context --current --namespace ${CARVEL_PACKAGE_NAMESPACE}
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

## Package

### Init

- Now it's time to use the `kctrl` tool to initialize the package using the interactive wizard.

{{< tabs >}}

{{< tab "Linux" >}}

```bash
kctrl --debug \
    package init \
        --chdir "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}"

# Once you have completed the wizard, take a look at the folder structure.
tree -a "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}"
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

- Create a build values file which will be read in when releasing the package.

{{< tabs >}}

{{< tab "Linux" >}}

```bash
cat <<- EOF >> "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}/build-values.yml"
# Name: build-values.yml
# Description: Carvel package build values for ${CARVEL_PACKAGE_NAME}
EOF
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

- Now that the package interactive initialization process is complete, edit the package files as required. For example you might like to;

  - Add additional directories to the export `includePaths` in `package-build.yml`
  - Add additional directories to the `ytt` paths in `package-build.yml`
  - Add custom `kapp` deployment flags in `package-build.yml`
  - Add additional `ytt` customizations and overlays
  - Modify the `package-resources.yml` to include config from secrets.

{{< tabs >}}

{{< tab "Linux" >}}

```bash
# Example to modify the PackageInstall to look for a secret for the values.
yq eval-all \
    --inplace \
    --expression \
        '
        .
            | select(.kind == "PackageInstall")
            |= (
                .spec.values[0].secretRef.name = ("${CARVEL_PACKAGE_NAME}-values" | envsubst(nu)),
                .spec.serviceAccountName = ("${CARVEL_PACKAGE_SA}" | envsubst(nu))
            )
        ' \
    "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}/package-resources.yml"
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

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
        --kbld-build \
        --namespace "${CARVEL_PACKAGE_NAMESPACE}" \
        --file "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}/package-resources.yml"
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

### Release

#### Release the Package

- Once you are ready to release the package, you can generate the `Package` and `PackageMetadata` CRDs using `release`.

{{< tabs >}}

{{< tab "Linux" >}}

```bash
kctrl --debug \
    package release \
        --openapi-schema=true \
        --build-ytt-validations=true \
        --chdir "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}" \
        --build-values "build-values.yml" \
        --copy-to "carvel-artifacts" \
        --repo-output "${CARVEL_PACKAGE_HOME}/repos/${CARVEL_PACKAGE_REPO}" \
        --tag "build-$(date +%Y-%m-%d).$((CARVEL_PACKAGE_COUNTER++))" \
        --version "${CARVEL_PACKAGE_VERSION}"
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

#### Release the a Repository

- Publish the Package Repository using the previously build `Package` and `PackageMetadata`.

{{< tabs >}}

{{< tab "Linux" >}}

```bash
kctrl package repository release \
    --chdir "${CARVEL_PACKAGE_HOME}/repos/${CARVEL_PACKAGE_REPO}" \
    --copy-to "${CARVEL_PACKAGE_HOME}/repos/${CARVEL_PACKAGE_REPO}/pkgrepo-build.yml" \
    --version "$(date +%Y-%m-%d)"
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

### Examples

Now that the package is ready, create ready-made examples used by `Package Consumers`. These are files are used to add to GitOps configurations or applied directly with `kubectl`.

- Create the example `PackageRepository` that contains the package just built.

{{< tabs >}}

{{< tab "Linux" >}}

```bash
cp --force \
    "${CARVEL_PACKAGE_HOME}/repos/${CARVEL_PACKAGE_REPO}/package-repository.yml" \
    "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}/examples/PackageRepository.yaml"
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

- Create the example `PackageInstall` that refers to the package just built.

{{< tabs >}}

{{< tab "Linux" >}}

```bash
# Split the file into multiple but only get the PackageInstall
yq eval-all \
    'select(.kind == "PackageInstall")' carvel/packages/portal.dcse.mil.au/package-resources.yml \
| \
yq \
    --split-exp \
        '
        ("${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}/examples/" + .kind + ".yaml" | envsubst(nu))
        '
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

- Create an example `Secret` that contains default values file for the `PackageInstall`

{{< tabs >}}

{{< tab "Linux" >}}

```bash
cat <<- EOF > "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}/examples/Secret.yaml"
---
apiVersion: v1
kind: Secret
metadata:
  name: ${CARVEL_PACKAGE_NAME}-values
  namespace: ${CARVEL_PACKAGE_NAMESPACE}
  annotations:
    tkg.tanzu.vmware.com/tanzu-package: ${CARVEL_PACKAGE_NAME}
stringData:
  values.yaml: |
    ---

    # Place your values to be read by the package install here.

    registry: harbor.internal.lan

EOF
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

### Test

So far we have;

- [x] Developed the Package
- [x] Tested the Package Locally
- [x] Released the Package to the Registry
- [x] Updated the Package in the Package Repository
- [x] Create examples for Package Consumers

The final test is to put our `Package Consumer` hat on and try out the the package from the Package Repository. In order to do this we will;

- [ ] Apply a `PackageRepository` CRD to the Cluster to know where to obtain packages from.
- [ ] Apply a `Secret` that our Carvel package will read installation values from
- [ ] Apply the `PackageInstall` object to install the Carvel package we made previously.

_Let's begin._

- Apply the latest `PackageRepository` to the Cluster which includes the recently build package.

{{< tabs >}}

{{< tab "Linux" >}}

```bash
# Deploy the Package Repository
kapp deploy \
    --app pkgr-${CARVEL_PACKAGE_REPO} \
    --file "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}/examples/PackageRepository.yaml"

# NOTE: This file is pinned to a specific shasum.
#       During development is can be easier to point to the latest mutable tag.
#       Then you can kick the pkgr to force a reconcile to the latest changes.

# Wait until it's reconciled before continuing
kubectl get pkgr -A
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

- Apply a `Secret` where the Carvel package values will be managed from.

{{< tabs >}}

{{< tab "Linux" >}}

```bash
kubectl apply \
    --filename \
        "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}/examples/Secret.yaml"
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

- Install the Carvel package imperatively for testing and watch the `kapp-controller` go to work.

{{< tabs >}}

{{< tab "Linux" >}}

```bash
# Imperative option for testing.
kctrl package install \
    --service-account-name "${CARVEL_PACKAGE_SA}" \
    --package-install ${CARVEL_PACKAGE_NAME} \
    --package ${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN} \
    --namespace "${CARVEL_PACKAGE_NAMESPACE}" \
    --version ${CARVEL_PACKAGE_VERSION} \
    --wait=true \
    --dry-run

# Or, use the example
kubectl apply \
    --filename "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}/examples/PackageInstall.yaml"

# Optionally, you can pass --values-file to provide testing overrides.
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

- **TIP:** When testing your package it can be useful to `kick` the resources forcing a reconcile loop after making changes.

{{< tabs >}}

{{< tab "Linux" >}}

```bash
# While bugs...

# Make a change...

# Apply all the things
kubectl apply \
    --filename "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}/examples"

# Kick the Package repository to force a reconcile.
kctrl package repository kick \
    --repository "${CARVEL_PACKAGE_REPO}.${CARVEL_PACKAGE_FQDN}" \
    --namespace "${CARVEL_PACKAGE_NAMESPACE}" \
    --yes

# Kick the Package install to force a reconcile
kctrl package installed kick \
    --package-install ${CARVEL_PACKAGE_NAME} \
    --namespace "${CARVEL_PACKAGE_NAMESPACE}" \
    --yes

# Done...
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}
