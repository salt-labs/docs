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

{{< tab "Linux" >}}

```bash
kind create cluster
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

- If you have not done so already, now is a good time to get the [Carvel](https://carvel.dev/) toolchain installed.

{{< tabs >}}

{{< tab "Linux" >}}

```bash
# curl method
curl -L https://carvel.dev/install.sh | bash

# wget method
wget -O- https://carvel.dev/install.sh | bash
```

{{< /tab >}}

{{< tab "macOS" >}}

```bash
# curl method
curl -L https://carvel.dev/install.sh | bash

# or if you are using homebrew
brew tap carvel-dev/carvel
brew install ytt kbld kapp imgpkg kwt vendir kctrl
```

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

- Now that you have a working Cluster, and the tools available locally, install `kapp-controller` into your Cluster. Note that if you are in an offline environment you will need to download the release manifest and modify to suit.

{{< tabs >}}

{{< tab "Linux" >}}

```bash
kubectl apply -f https://github.com/carvel-dev/kapp-controller/releases/latest/download/release.yml
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

## Questions

You need to prepare your mind 🧠 and do some research before continuing.

Prepare answers to these questions before continuing.

- What package are you building today?
- What is the package name?
- What is the package version?
- Are you building container images or using a pre-built release?
- What type of upstream artifact is it (Helm, Manifests, etcetera)
- What are the URLs or Folders where the upstream artifacts are sourced from
- Which Container Registry will the resulting package and repository be pushed to?

## Variables

- The next step is to define variables about your package to make the subsequent steps easier.

{{< tabs >}}

{{< tab "Linux" >}}

```bash
# Set the full path to the root level folder that will house all packages and repos.
export CARVEL_PACKAGE_HOME="$(pwd)/carvel"

# Set the Namespace where you will be managing carvel packages from.
export CARVEL_PACKAGE_NAMESPACE="carvel"

# Set the Service Account used to install Carvel packages
export CARVEL_PACKAGE_SA="kapp-controller-sa"

# Set a name for your Carvel package repository.
export CARVEL_PACKAGE_REPO="kapps"

# Set the FQDN for the Carvel packages
export CARVEL_PACKAGE_FQDN="saltlabs.tech"

# Set the name of the package we will be creating
export CARVEL_PACKAGE_NAME="portal"

# Set the version of the package you are creating.
export CARVEL_PACKAGE_VERSION="0.0.1"

# Where is the container registry you will be using?
export OCI_REGISTRY="ghcr.io"

# What is the name of the Project/Org/Library within the image registry
# Different registries call this different things,
# but it will be used the suffix added after the registry.
export OCI_PROJECT="salt-labs/${CARVEL_PACKAGE_NAMESPACE}"

# Initialize a counter for your development loop.
export CARVEL_PACKAGE_COUNTER=0
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}
