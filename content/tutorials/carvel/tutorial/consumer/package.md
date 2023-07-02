---
title: "Package"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "Carvel Package"
type: "docs"
weight: 3602
draft: false
---

Now that the package is available, it's _finally_ time to actually install it!

- Applications are managed by storing the configuration in source control. This is managed by a minimum of two resources, a `PackageInstall` and a `Secret`.

- _These will need to be included with every created package as user examples for installation. You can see the examples below which you can `kubectl apply` for testing locally._

- Create the `PackageInstall` resource.

{{< tabs "consumer-pkgi" >}}

{{< tab "Linux" >}}

```bash
cat <<- _EOF_ > ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/examples/PackageInstall.yaml
---
apiVersion: packaging.carvel.dev/v1alpha1
kind: PackageInstall
metadata:
  name: ${PACKAGE_NAME}
  namespace: ${PACKAGE_NAMESPACE}
spec:
  serviceAccountName: ${PACKAGE_NAMESPACE}-sa
  packageRef:
    refName: ${PACKAGE_NAME}.${PACKAGE_FQN}
    versionSelection:
      constraints: ${PACKAGE_VERSION}
  values:
    - secretRef:
        name: ${PACKAGE_NAME}-values
_EOF_
```

{{< /tab >}}

{{< /tabs >}}

- Create a `Secret` which is how the custom values are applied to the package. This is similar to a Helm values file.

{{< tabs "consumer-secret" >}}

{{< tab "Linux" >}}

```bash
cat <<- _EOF_ > ${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/examples/Secret.yaml
---
apiVersion: v1
kind: Secret
metadata:
  name: ${PACKAGE_NAME}-values
  namespace: ${PACKAGE_NAMESPACE}
  annotations:
    tkg.tanzu.vmware.com/tanzu-package: ${PACKAGE_NAME}
stringData:
  values: |
    ---
    replicaCount: 1

    service:
      type: ClusterIP
      port: 80
_EOF_
```

{{< /tab >}}

{{< /tabs >}}

- Apply these resources to your cluster for testing.

{{< tabs "consumer-kubectl" >}}

{{< tab "Linux" >}}

```bash
kubectl apply -f "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/examples"
```

{{< /tab >}}

{{< /tabs >}}

- Check the package reconciled successfully

{{< tabs "consumer-check" >}}

{{< tab "Linux" >}}

```bash
kubectl get pkgi -n ${PACKAGE_NAMESPACE} -w
```

{{< /tab >}}

{{< /tabs >}}

- Check out the super important application and make sure it looks healthy.

{{< tabs "consumer-check-pods" >}}

{{< tab "Linux" >}}

```bash
kubectl get all -n "${DEPLOY_NAMESPACE}"
```

{{< /tab >}}

{{< /tabs >}}

- **Bonus round:** Have a go at exposing the application outside your cluster via the Contour Ingress Controller.

```bash
# HINT: If you get stuck, there is a sample at .config/custom/manifests/pacman/HTTPProxy.yaml to get you started.

# Reminder: DNS needs to work first :)
firefox http://pacman.cluster.local
```
