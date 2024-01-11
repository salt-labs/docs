---
title: "imgpkg"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "Imgpkg Bundles"
type: "docs"
weight: 3708
draft: false
---

Now it's time to push the imgpkg bundle that you have created locally to the image registry as an OCI compatible image.

For further documentation on the imgpkg available options see [carvel.dev/imgpkg](https://carvel.dev/imgpkg/docs/develop/).

- First, let's define metadata about the `bundle`

{{< tabs "imgpkg-metadata" >}}

{{< tab "Linux" >}}

```bash
cat <<- _EOF_ > "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/.imgpkg/bundle.yml"
---
apiVersion: imgpkg.carvel.dev/v1alpha1
kind: Bundle

metadata:
  name: ${PACKAGE_NAME}

authors:
  - name: ${PACKAGE_AUTHOR}
    email: ${PACKAGE_AUTHOR_EMAIL}

websites:
  - url: ${PACKAGE_WEBSITE}
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

- Push the imgpkg bundle to your image registry so it's ready for consumption.

{{< tabs "imgpkg-push" >}}

{{< tab "Linux" >}}

```bash
imgpkg push  \
  --file "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/" \
  --bundle ${OCI_REGISTRY}/${OCI_PROJECT}/packages/${PACKAGE_NAME}:${PACKAGE_VERSION} \
  --lock-output "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/BundleLock.yaml" \
  --registry-ca-cert-path "${HOME}/.docker/certs.d/${OCI_REGISTRY}/ca.crt"
```

{{< /tab >}}

{{< tab "macOS" >}}

**Do you use macOS? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< tab "Windows" >}}

**Do you use Windows? Why not [contribute](https://github.com/salt-labs/docs) the commands that you would run here...**

{{< /tab >}}

{{< /tabs >}}

- Optionally, load up the image registry web UI and take a look at the package you have just created.

{{< notice note >}}🥳 **Congratulations** 🥳 If you have made it this far, congratulations! The individual package is now ready!
{{< /notice >}}
