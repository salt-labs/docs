---
title: "Prepare"
date: 2024-01:01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "Prepare a development environment"
type: "docs"
weight: 3601
draft: false
---

## Environment

The first step is to prepare a development environment where you will iterate on your Carvel package development.

In order to test the package we need a kubernetes cluster. For this we recommended [kind](https://kind.sigs.k8s.io/) but [microk8s](https://microk8s.io/) and [minikube](https://minikube.sigs.k8s.io/docs/start/) are other popular options.

- Example creating a new Cluster with kind

{{< tabs >}}

{{< tab "Cross Platform" >}}

```bash
kind create cluster
```

{{< /tab >}}

{{< /tabs >}}

- If you have not done so already, now is a good time to install `kctrl` by downloading the binary for your OS from the [releases](https://github.com/carvel-dev/kapp-controller/releases) page.

{{< tabs >}}

{{< tab "Cross Platform" >}}

```bash
kctrl version
```

{{< /tab >}}

{{< /tabs >}}

## Mind

You need to prepare your mind 🧠 and do some research before continuing.

Prepare answers to these questions before continuing.

- What package are you building today?
  - Name
  - Version
- Am I building container images or using a pre-built release?
- What type of release (Helm, Manifets, etcetera)
- What are the URLs or Folders where the upstream artifacts are sourced from
- Where will the

## Variables

The next step is to define variables about your package to make the subsequent steps easier.

- Do this step

{{< tabs >}}

{{< tab "Linux" >}}

```bash
# Set the full path to the root level folder that will house all packages and repos.
CARVEL_PACKAGE_HOME="$(pwd)/carvel"

# Set the Namespace where you will be managing carvel packages from.
CARVEL_PACKAGE_NAMESPACE="kapps"

# Set a name for your Carvel package repository
CARVEL_PACKAGE_REPO="kapps"

# Set the FQDN for the Carvel packages
CARVEL_PACKAGE_FQDN="saltlabs.tech"

# Set the name of the package we will be creating
CARVEL_PACKAGE_NAME="portal"

# Set the version of the package you are creating.
CARVEL_PACKAGE_VERSION="0.0.1"

# Where is the container registry you will be using?
OCI_REGISTRY="ghcr.io"

# What is the name of the Project/Org/Library within the image registry
# Different registries call this different things,
# but it will be used the suffix added after the registry.
OCI_PROJECT="salt-labs/kapps"
```

{{< /tab >}}

{{< tab "macOS" >}}

**TODO:** Put commands here for macOS

{{< /tab >}}

{{< tab "Windows" >}}

**TODO:** Put commands here for Windows

{{< /tab >}}

{{< /tabs >}}
