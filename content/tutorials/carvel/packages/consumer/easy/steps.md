---
title: "Steps"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "Steps"
type: "docs"
weight: 3801
draft: false
---

### Overview

Deploying a Carvel package is similar to Helm where the default installation might not be suitable for your environment. In order to customize the installation we need to configure the values the package will use.

There are different mechanisms available in the [spec](https://carvel.dev/kapp-controller/docs/latest/app-spec/) including from; files, config maps and secrets.

In this example we will use a `Secret`.

**NOTE:** These steps depend on your having already completed the `Package Author` tutorial for the required files.

### Define Values

- Edit and the `Secret` with values required for your application.

{{< tabs "variables" >}}

{{< tab "Linux" >}}

```bash
# Edit the secret
vim "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}/examples/Secret.yaml"
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

### Apply Custom Resources

- Apply the `PackageRepository`, `Secret` and `PackageInstall` custom resources.

{{< tabs "variables" >}}

{{< tab "Linux" >}}

```bash
kubectl apply \
    --filename "${CARVEL_PACKAGE_HOME}/packages/${CARVEL_PACKAGE_NAME}.${CARVEL_PACKAGE_FQDN}/examples/PackageInstall.yaml"
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

### Verify

- Verify the installation

{{< tabs "variables" >}}

{{< tab "Linux" >}}

```bash
# Check the custom resources have reconciled.
kubectl get pkgr,pkg,pkgm,pkgi -n ${CARVEL_PACKAGE_NAMESPACE}

# Check the health of your app via usual methods.
kubectl get all -n ${APP_NAMESPACE}
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

- If there was an issue, it's time to [troubleshoot](/tutorials/carvel/packages/consumer/easy/troubleshoot/)
