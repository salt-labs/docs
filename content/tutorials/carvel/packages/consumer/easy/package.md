---
title: "Package"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "Carvel Package"
type: "docs"
weight: 3803
draft: false
---

Now that the package is available, it's _finally_ time to actually install it!

The `Package Author` has kindly created some examples for you to use as a starting point in you're own cluster.

- Take a copy of the `PackageInstall` and `Secret` resources.

{{< tabs "consumer-crs" >}}

{{< tab "Linux" >}}

```bash
# Create a durectory for the values.
mkdir -p /tmp/tutorial-values

# Copy the sample values files.
cp "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/examples/{PackageInstall,Secret}.yaml" /tmp/tutorial-values/
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

- Now, let's edit the Secret with your own custom values.

{{< tabs "consumer-secret" >}}

{{< tab "Linux" >}}

```bash
# Everybody uses vim right?
vim /tmp/tutorial-values/Secret.yaml
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

- Apply these resources to your cluster for testing.

{{< tabs "consumer-kubectl" >}}

{{< tab "Linux" >}}

```bash
# Apply the values file to the cluster
kubectl apply -f /tmp/tutorial-values
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

- Check the package reconciled successfully

{{< tabs "consumer-check" >}}

{{< tab "Linux" >}}

```bash
kubectl get pkgi -n ${PACKAGE_NAMESPACE} -w
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

- Check out the super important application and make sure it looks healthy.

{{< tabs "consumer-check-pods" >}}

{{< tab "Linux" >}}

```bash
kubectl get all -n "${DEPLOY_NAMESPACE}"
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

- **Bonus round:** Have a go at exposing the application outside your cluster via the Contour Ingress Controller.

```bash
# HINT: If you get stuck, there is a sample at .config/custom/manifests/pacman/HTTPProxy.yaml to get you started.

# Reminder: DNS needs to work first :)
firefox http://pacman.cluster.local
```
