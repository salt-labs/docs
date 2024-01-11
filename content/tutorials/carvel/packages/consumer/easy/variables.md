---
title: "Variables"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "Variables"
type: "docs"
weight: 3801
draft: false
---

In order to make it easier to work through the tutorial, we will define all the required variables upfront.

These are all relative to the _root_ folder of where you will be working from.

_Note that all commands from this point will use these so choose carefully._

If you just completed the `Package Author` tutorial and are now following on with this one, you don't need to redefine these as they should already be set.

{{< tabs "variables" >}}

{{< tab "Linux" >}}

```bash
# Define the name for the top level folder that will hold the package and repo.
ROOT_DIR="kapps"

# What is the name of the repository where this package will be stored?
REPOSITORY_NAME="local"

# What is the unique name of your package?
PACKAGE_NAME="pacman-carvel-test-${USER}"

# What is the namespace where your packages and repositories metadata is managed from?
PACKAGE_NAMESPACE="kapps"

# Where will your application be deployed into inside the cluster?
DEPLOY_NAMESPACE="pacman-carvel-test"

# What is the FQN your package will use? ie, <package_name>.<package_fqn>
PACKAGE_FQN="saltlabs.tech"

# What is the version number of the package you are creating?
PACKAGE_VERSION="0.0.1"

# What is a good description of your package (short)
PACKAGE_DESC_SHORT="chomp chomp"

# How do you want your package name displayed in UIs?
PACKAGE_DISPLAY="Pacman"

# What is a good description of your package (long)
PACKAGE_DESC_LONG="A very mission critical application."

# What is a TLDR change description for this package version?
PACKAGE_RELEASE_NOTES="Fixed a bug with the widget collector."

# Package Author name
PACKAGE_AUTHOR="MAHDTech"

# Package Author email
PACKAGE_AUTHOR_EMAIL="MAHDTech@saltlabs.tech"

# Package Author website
PACKAGE_WEBSITE="https://saltlabs.tech"

# What is the version of the repository you will be creating?
REPOSITORY_VERSION="$(date +%Y-%m-%d)"

# Where is the container registry you will be using?
OCI_REGISTRY="ghcr.io"

# What is the name of the Project/Org/Library within the image registry
# Different registries call this different things,
# but it will be used the suffix added after the registry.
OCI_PROJECT="salt-labs/kapps"
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}
