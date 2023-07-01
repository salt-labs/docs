---
title: "Repository"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "Carvel Package Repository"
type: "docs"
weight: 3601
draft: false
---

In order for `kapp-controller` to be able to _find_ the package, the package metadata needs to be available within the cluster. Once the metadata is available, you can then `PackageInstall` your package.

- Install the `PackageRepository` resource into your cluster.

{{< tabs "consumer-pkgr" >}}

{{< tab "Linux" >}}

```bash
kapp deploy \
  --app ${REPOSITORY_NAME} \
  --file "${ROOT_DIR}/repos/${REPOSITORY_NAME}/examples/PackageRepository.yaml" \
  --yes

kubectl get PackageMetadata -n ${PACKAGE_NAMESPACE}

kubectl get Packages -n ${PACKAGE_NAMESPACE}
```

{{< /tab >}}

{{< /tabs >}}

- [x] Make sure the repository is in the state `Reconcile Succeeded` before proceeding.

{{< tabs "consumer-reconciled" >}}

{{< tab "Linux" >}}

```bash
kubectl get PackageRepository -n ${PACKAGE_NAMESPACE} -w
```

{{< /tab >}}

{{< /tabs >}}
