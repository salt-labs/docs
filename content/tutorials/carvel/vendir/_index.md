---
title: "vendir"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "vendir"
type: "docs"
weight: 3301
draft: false
---

## Overview

`vendir` is a tool that allows you to declaratively define a set of data resources in a consistent structure.

An analogy for describing `vendir` is _git submodules on steroids_.

## Theory

{{< collapse "Outcomes" >}}

- [ ] Know what _vendir_ is and how it fits into the `Carvel` toolchain.

{{</ collapse >}}

- Review the `vendir` documentation

{{< button label="Review documentation (30min)" link="https://carvel.dev/vendir/docs/latest/" >}}
<br/>

## Practical

{{< collapse "Outcomes" >}}

- [ ] Know how to use _vendir_ for obtaining upstream dependencies.

{{</ collapse >}}

### Pre-requisites

If you intend on completing the tutorial section there are some pre-requisites.

- [ ] Linux environment with admin permissions

if using a Windows Laptop, the suggestion is to have either WSL installed or have available a Hyper-V Linux VM.

### Tutorial

Prior to starting the tutorial, you need to have the Carvel toolchain installed and available locally. Full installation instructions are available over at [carvel.dev](https://carvel.dev/).

- [ ] Install Carvel

{{< tabs "install-carvel-vendir" >}}

{{< tab "macOS" >}}

```bash
wget -O- https://carvel.dev/install.sh | sudo bash
```

{{</ tab >}}

{{< tab "Linux" >}}

```bash
wget -O- https://carvel.dev/install.sh | sudo bash
```

{{</ tab >}}

{{< /tabs >}}

- [ ] Install `helm`

{{< tabs "install-helm-vendir" >}}

{{< tab "macOS" >}}

```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

{{</ tab >}}

{{< tab "Linux" >}}

```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

{{</ tab >}}

{{< /tabs >}}

- [ ] Install `kustomize`

{{< tabs "install-kustomize-vendir" >}}

{{< tab "macOS" >}}

```bash
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

sudo mv kustomize /usr/local/bin/
```

{{</ tab >}}

{{< tab "Linux" >}}

```bash
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

sudo mv kustomize /usr/local/bin/
```

{{</ tab >}}

{{< /tabs >}}

- [ ] Install `yq`

{{< tabs "install-yq-vendir" >}}

{{< tab "macOS" >}}

```bash
# https://github.com/mikefarah/yq/releases
YQ_VERSION="v4.24.2"
YQ_URL="https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64"
YQ_URL_CHECKSUMS="https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/checksums"

curl \
    --location \
    --insecure \
    --output yq_linux_amd64 \
    ${YQ_URL} \
 && curl \
    --location \
    --insecure \
    --output yq.checksums \
    "${YQ_URL_CHECKSUMS}" \
 && chmod +x yq_linux_amd64 \
 && echo "$(grep "yq_linux_amd64 " yq.checksums | tr -s ' ' | cut -d ' ' -f 19)  yq_linux_amd64" | sha256sum --check \
 && sudo mv yq_linux_amd64 /usr/local/bin/yq \
 && yq --version \
 && rm yq.checksums
```

{{</ tab >}}

{{< tab "Linux" >}}

```bash
# https://github.com/mikefarah/yq/releases
YQ_VERSION="v4.24.2"
YQ_URL="https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64"
YQ_URL_CHECKSUMS="https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/checksums"

curl \
    --location \
    --insecure \
    --output yq_linux_amd64 \
    ${YQ_URL} \
 && curl \
    --location \
    --insecure \
    --output yq.checksums \
    "${YQ_URL_CHECKSUMS}" \
 && chmod +x yq_linux_amd64 \
 && echo "$(grep "yq_linux_amd64 " yq.checksums | tr -s ' ' | cut -d ' ' -f 19)  yq_linux_amd64" | sha256sum --check \
 && sudo mv yq_linux_amd64 /usr/local/bin/yq \
 && yq --version \
 && rm yq.checksums
```

{{</ tab >}}

{{< /tabs >}}

`vendir` reads from a single configuration file named `vendir.yml`. Full information about all supported configuration options is available in the [specification](https://carvel.dev/vendir/docs/latest/vendir-spec/).

- [ ] Create an example `vendir.yml` file as follows:

{{< tabs "configure-vendir" >}}

{{< tab "macOS" >}}

```bash
cat <<- _EOF_ > "vendir.yml"
apiVersion: vendir.k14s.io/v1alpha1
kind: Config
minimumRequiredVersion: 0.12.0
directories:

- path: vendor
  contents:

  - path: custom-repo-custom-version
    helmChart:
      name: contour
      version: "1.2.1"
      repository:
        url: https://charts.bitnami.com/bitnami
_EOF_
```

{{</ tab >}}

{{< tab "Linux" >}}

```bash
cat <<- _EOF_ > "vendir.yml"
apiVersion: vendir.k14s.io/v1alpha1
kind: Config
minimumRequiredVersion: 0.12.0
directories:

- path: vendor
  contents:

  - path: custom-repo-custom-version
    helmChart:
      name: contour
      version: "1.2.1"
      repository:
        url: https://charts.bitnami.com/bitnami
_EOF_
```

{{</ tab >}}

{{< /tabs >}}

Now that the configuration file has been created, execute the utility now to pull down the dependencies.

- [ ] Run `vendir`

{{< tabs "sync-vendir" >}}

{{< tab "Linux" >}}

```shell
vendir sync
```

{{</ tab >}}

{{< /tabs >}}

The tool will automatically create a lock file in the current directory, take a look at it now.

- [ ] Inspect the lock file

{{< tabs "inspect-vendir" >}}

{{< tab "macOS" >}}

```shell
cat vendir.lock.yml
```

{{</ tab >}}

{{< tab "Linux" >}}

```shell
cat vendir.lock.yml
```

{{</ tab >}}

{{< /tabs >}}

As defined in the configuration file, the downloaded contents are stored in the `vendor` directory.

- [ ] Inspect the contents of the `vendor` directory

{{< tabs "vendor-vendir" >}}

{{< tab "macOS" >}}

```shell
tree -a vendor
```

{{</ tab >}}

{{< tab "Linux" >}}

```shell
tree -a vendor
```

{{</ tab >}}

{{< tab "Windows" >}}

```PowerShell
tree /F vendor
```

{{</ tab >}}

{{< /tabs >}}

The basic `vendir` tutorial is now complete!

For a longer form tutorial check out how `vendir` fits into a _carvel package_ [the hard way](../tutorial)
