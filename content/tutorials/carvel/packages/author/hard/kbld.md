---
title: "kbld"
date: 2021-03-01T00:00:00+00:00
icon: "fa-solid fa-box"
description: "Resolving images"
type: "docs"
weight: 3706
draft: false
---

A common best practice is to use _immutable_ image references when deploying containerised applications. Often vendors are ~~lazy~~ forgetful and provide helm charts and manifests using image tags like this;

```yaml
image: mycontainer:latest
```

This is **bad practice** in several ways, one of which is using a mutable image reference. If the upstream vendor pushes a new image using the same tag, if you were to deploy it again you will get a different result.

_Won't somebody think of the ~~children~~ supply chain?_

Of course, Kubernetes does help us with the `ImagePullPolicy` options, but this is not the final solution.

Instead, we can use an image resolver to lock our supply chain making each deployment predictable and repeatable.

💪 **_`kbld` enters the room_** 💪

The next step is to resolve and record any image references found by scanning the `vendor` directory.

For further documentation on the kbld available options see [carvel.dev/kbld](https://carvel.dev/kbld/docs/latest/config/).

In order for `kbld` to operate, the tool requires a valid yaml configuration file. _Let's create an empty one now._

- Create a basic kbld config file.

{{< tabs "kbld-config" >}}

{{< tab "Linux" >}}

```bash
cat <<- _EOF_ > "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/kbld/Config.yaml"
---
apiVersion: kbld.k14s.io/v1alpha1
kind: Config
minimumRequiredVersion: 0.31.0
_EOF_
```

{{< /tab >}}

{{< /tabs >}}

Now it's time to run `kbld` to resolve the images. For templates such Helm Charts, you can pass the templated output as input to the `kbld` cli.

- Here is an example for our Helm chart from this tutorial.

{{< tabs "kbld-help" >}}

{{< tab "Linux" >}}

```bash
# NOTE: You need to run this for this tutorial.
helm template kbld \
  "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/vendor/helm" \
| \
kbld \
  --file "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/kbld/Config.yaml" \
  --file - \
  --imgpkg-lock-output "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/.imgpkg/images.yml"
```

{{< /tab >}}

{{< /tabs >}}

- Here is another example, if you were using YAML manifests.

{{< tabs "kbld-yaml" >}}

{{< tab "Linux" >}}

```bash
# NOTE: You don't need to run this for this tutorial!
kbld \
  --file "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/kbld/Config.yaml" \
  --file "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/vendor/manifests/" \
  --imgpkg-lock-output "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/.imgpkg/images.yml"
```

{{< /tab >}}

{{< /tabs >}}

- Now check the images have been resolved successfully.

{{< tabs "kbld-check" >}}

{{< tab "Linux" >}}

```bash
cat "${ROOT_DIR}/packages/${PACKAGE_NAME}/${PACKAGE_VERSION}/bundle/.imgpkg/images.yml"
```

{{< /tab >}}

{{< /tabs >}}

Now, you might be asking, What does this even mean?

- When the package is built today, 3 weeks from now, or 3 years from now, the result will be the same (so long as the upstream exists at build time)
- If the upstream vendor pushes a new image to the same tag, it will not affect the resulting package (unless you re-run kbld and re-resolve the images)
- You can even reference bundles from bundles, meaning no further network access is required to pull those images for offline support.
- For auditing, you can forever see the supply chain with the contents that made up this version of the package.
- And later we will scan the images for vulnerabilities.
