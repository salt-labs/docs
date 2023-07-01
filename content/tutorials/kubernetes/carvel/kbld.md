---
title: "kbld"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "kbld"
type: "docs"
weight: 3303
draft: false
---

## Overview

`kbld` is an image solver to automate the process of building, pushing and resolving image references in development and deployment workflows.

A common use case is to resolve all immutable image references automatically and produce image lock files.

## Theory

{{< collapse "Outcomes" >}}

- [ ] Know what _kbld_ is and how it fits into the `Carvel` toolchain.

{{</ collapse >}}

- Review the `kbld` documentation

{{< button label="Review documentation (45min)" link="https://carvel.dev/kbld/docs/latest/" >}}
<br/>

## Practical

{{< collapse "Outcomes" >}}

- [ ] Know how to use _kbld_ for resolving image references.

{{</ collapse >}}

- [ ] Create a `kbld` configuration file

{{< tabs "kbld-config" >}}

{{< tab "Linux" >}}

```bash
cat <<- _EOF_ > "kbld.yaml"
---
apiVersion: kbld.k14s.io/v1alpha1
kind: Config
minimumRequiredVersion: 0.31.0
searchRules:
  - keyMatcher:
    path:
      - spec
      - images:
        allIndexes: true
  - keyMatcher:
    name: image
    updateStrategy:
      entireValue: {}
_EOF_
```

{{< /tab >}}

{{< /tabs >}}

- [ ] Create some sample YAML including images.

{{< tabs "kbld-source" >}}

{{< tab "Linux" >}}

```bash
cat << _EOF_ > "source.yaml"
apiVersion: v1
kind: Thing
spec:
    image: docker.io/busybox
_EOF_
```

{{</ tab >}}

{{< /tabs >}}

- [ ] Run the file through `kbld`

{{< tabs "kbld-stdout" >}}

{{< tab "Linux" >}}

```bash
cat source.yaml | kbld --file -
```

{{< /tab >}}

{{< /tabs >}}

`kbld` will resolve the immutable reference and output to screen. But this is not super useful by itself. Instead the output can be read as input by other tools.

- [ ] Write the resolved image references in a format compatible with `imgpkg`

{{< tabs "kbld-imgpkg" >}}

{{< tab "Linux" >}}

```bash
cat source.yaml | \
kbld \
    --file - \
    --img-lock-output images.yml
```

{{</ tab >}}

{{< /tabs >}}

The basic `kbld` tutorial is now complete!

For a longer form tutorial check out how `kbld` fits into a _carvel package_ [the hard way](../tutorial)
