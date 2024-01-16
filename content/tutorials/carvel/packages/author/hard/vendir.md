---
title: "vendir"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "Vendoring upstream dependencies"
type: "docs"
weight: 3704
draft: false
---

Now it's time to configure where `vendir` will pull the upstream content from.

For further documentation on the `vendir` available options see [carvel.dev/vendir](https://carvel.dev/vendir/docs/develop/).

- Create the `vendir` configuration file that we will use for this tutorial.

{{< tabs "vendir-config" >}}

{{< tab "Linux" >}}

```bash
cat <<- _EOF_ > "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/vendir/Config.yaml"
---
apiVersion: vendir.k14s.io/v1alpha1
kind: Config
minimumRequiredVersion: 0.30.0
directories:
  - path: vendor
    contents:
      - path: helm
        helmChart:
          name: pacman
          version: "0.1.7"
          repository:
            url: https://shuguet.github.io/pacman/
          helmVersion: ""
_EOF_

cat <<- _EOF_ > "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/vendir/LockConfig.yaml"
# This file is generated automatically by vendir and will be updated with resolved image references by kbld later.
_EOF_
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

- Execute `vendir` to pull down the upstream content unmodified and place it into the `vendor` folder.

{{< tabs "vendir-sync" >}}

{{< tab "Linux" >}}

```bash
vendir sync \
  --file "vendir/Config.yaml" \
  --lock-file "vendir/LockConfig.yaml" \
  --chdir "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle"

# Take a look at the upstream content you just downloaded.
tree -a "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/vendor"
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}
